/*
   Init for the Official LFS LiveCD
   Written by Jeremy Huntwork, based on code by Chris Lingard.
   Major overhaul/reorganization by James Lee on 2005-01-06.

   This code sets up a directory structure for the cd in the initramfs,
   finds and mounts the LFS LiveCD, makes essential symlinks to read-
   only directories on the cd and starts udev.  Finally it passes
   control over to sysvinit to finish the boot process.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <sys/mount.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <linux/cdrom.h>
#include <linux/reboot.h>

#define CDROM_MOUNT   "/.cdrom"           /* Mount point for CD */
#define CDROM_FSTYPE  "iso9660"           /* Filesystem of CD (could be udf? :) */
#define LFSID_FILE    CDROM_MOUNT "/LFS"  /* The file the LFS ID is stored in */
#define LFSID_STRING  "LFS-6.0-LIVECD"     /* Text expected in the file */
#define MAX_RETRIES   3                   /* How many times to retry scanning for the liveCD */


/* Devices to check for the LFS-CD, could scan some stuff in /proc in a later version */
const char *devices[] = 
{
	"/dev/hda", "/dev/hdb", "/dev/hdc", "/dev/hdd", "/dev/hde", "/dev/hdf", "/dev/hdg", "/dev/hdh",
	"/dev/sr0", "/dev/sr1", "/dev/sr2", "/dev/sr3", "/dev/sr4", "/dev/sr5", "/dev/sr6", "/dev/sr7",
	NULL,
};

/* Dunno what this MAX_ thing is about, i'll just leave it, if it works */
#define MAX_INIT_ARGS 8
#define MAX_INIT_ENVS 8
char *init_envp[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
char *init_argv[MAX_INIT_ARGS+2] = { "init", NULL, };

/* The var tree, just mkdir()'ed */
const char *var_tree[] = {
	"var",
	"var/cache", "var/empty", "var/lib", "var/local", "var/lock", 
	"var/log",   "var/mail",  "var/opt", "var/run",   "var/spool", 
	"var/lib/locate", "var/lib/misc", "var/lib/nfs", "var/lib/xkb", "var/lib/xdm",
	NULL,
};

/* Links to be made */
const char *cdrom_links[][2] = 
{
	{CDROM_MOUNT "/bin",  "bin"},
	{CDROM_MOUNT "/lib",  "lib"},
	{CDROM_MOUNT "/sbin", "sbin"},
	{CDROM_MOUNT "/etc",  "etc"},
	{CDROM_MOUNT "/boot", "boot"},
	{NULL, NULL},
};

const char *proc_links[][2] = 
{
	{"/proc/self/fd",   "/dev/fd"},
	{"/proc/self/fd/0", "/dev/stdin"},
	{"/proc/self/fd/1", "/dev/stdout"},
	{"/proc/self/fd/2", "/dev/stderr"},
	{"/proc/kcore",     "/dev/core"},
	{NULL, NULL},
};


int mountlfscd(void);
inline int vfsmount(char *target, char *fs, int perms, char *params);

int main(void)
{
	int i;
	
	umask(0);
	
	printf("Initramfs activated\n");

	vfsmount("/proc", "proc",  0755, NULL);
	vfsmount("/sys",  "sysfs", 0755, NULL);

	mkdir(CDROM_MOUNT, 0755);

	for (i=0;i<MAX_RETRIES;i++)
	{
		if (mountlfscd())
			break;

		/* Failed to find any device with an lfs boot cd in :( */
		printf("I couldn't find an LFS LiveCD in any drive!!\n");
		printf("I'm going to wait 10 seconds and try again (Try %d/%d)\n", i, MAX_RETRIES);
		sleep(10);
	}

	if (i>=MAX_RETRIES)
	{
		printf("I couldn't find an LFS LiveCD in any drive after %d retries!\n", MAX_RETRIES);
		reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_HALT, NULL);
		return(1);
	}

	/* If we're here, we have an lfs cd mounted and verified */
	printf("Building Directory Structure...\n");
	mkdir("tmp", 01777);
	mkdir("root", 01750);

	/* Make var directories */
	for (i=0;var_tree[i]!=NULL;i++)
		mkdir(var_tree[i], 0755);

	/* Make some links */
	for(i=0;cdrom_links[i][0]!=NULL;i++)
		symlink(cdrom_links[i][0], cdrom_links[i][1]);

	printf("Populating /dev with device nodes...\n");

	i = mount("none", "/dev", "ramfs", 0, NULL);
	if (i<0)
		printf("Failed to mount /dev: %s\n", strerror(errno));

	system("/sbin/udevstart");

	/* Make some links */
	for(i=0;proc_links[i][0]!=NULL;i++)
		symlink(proc_links[i][0], proc_links[i][1]);

	/* Mount some stuff*/
	vfsmount("/dev/pts", "devpts", 0755, "gid=4,mode=620");
	vfsmount("/dev/shm", "tmpfs", 01777, NULL);

	/* We're done!! */
	printf("Starting init...\n");
	i = execve("/sbin/init", init_argv, init_envp);
	if (i<0)
		printf("Failed to start init: %s :(\n", strerror(errno));

	return(0);
}

/* Mount a virtual file system */
inline int vfsmount(char *target, char *fs, int perms, char *params)
{
	int i;
	printf("Mounting %s...\n", target);
	mkdir(target, perms);
	i = mount("none", target, fs, 0, params);
	if (i<0)
	{
		printf("Failed to mount %s[%s]: %s\n", target, fs, strerror(errno));
		return(-1);
	}
	return(0);
}

/* This will look for and mount an LFS CD, if found/mounted it'll return 1, otherwise 0 */
int mountlfscd(void)
{
	int i;

	for(i=0;devices[i]!=NULL;i++)
	{
		int fd, status;
		const char *curdevice = devices[i];
		char buf[32];

		/* Try to open CD drive to see if we can use it */
		fd = open(curdevice, O_RDONLY | O_NONBLOCK);
		if (fd<0)
		{
			/*
				We'll get here if we can't open the device
				(No such device, No such file or directory, etc, etc)
			*/
			printf("%s: open failed: %s\n", curdevice, strerror(errno));
			continue; /* On to the next device!! */
		}

		/* Try to see what the status of the CD drive is */
		status = ioctl(fd, CDROM_DRIVE_STATUS, 0);
		if (status<0)
		{
			/* We'll probably get here if we open a hard disk */
			/* printf("%s: ioctl failed: %s\n", curdevice, strerror(errno)); */
			close(fd);
			continue; /* On to the next device!! */
		} 

		close(fd); /* We don't need this fd any more */

		if (status != CDS_DISC_OK)
		{
			/* We'll probably get here if there's no CD in the drive */
			printf("%s: Drive not ready\n", curdevice);
			continue; /* On to the next device!! */
		}

		/* If we're here, the cd drive seems to have a disc in it, and is okay! */

		/* Try to mount the cd drive*/
		status = mount(curdevice, CDROM_MOUNT, CDROM_FSTYPE, MS_RDONLY, NULL);
		if (status<0)
		{
			printf("%s: mount failed: %s\n", curdevice, strerror(errno));
			continue; /* On to the next device!! */
		} 

		/* If we're here, we have definatly have a data CD mounted at the mount point :) */


		/* Lets try to make sure it's the LFS LiveCD :) */	
		fd = open(LFSID_FILE, O_RDONLY);
		if (fd<0)
		{
			printf("%s: Not our LFS LiveCD!\n", curdevice);
			continue; /* On to the next device!! */
		}
		
		memset(buf, 0, 32); /* Clear buffer so we don't have to check read's status */
		read(fd, buf, 13);
		close(fd);

		if (memcmp(buf, LFSID_STRING, strlen(LFSID_STRING)))
		{
			printf("%s: %s incorrect data\n", curdevice, LFSID_FILE);
			status = umount(curdevice);
			if (status<0)
				printf("%s: umount failed: %s\n", curdevice, strerror(errno));
				/* (don't care if umount failed, not much we can do about it, but nice to say anyway) */
			continue; /* On to the next device!! */
		}

		/* YAY! we have the lfs boot cd mounted :) */
		printf("%s: LFS CD Verified\n", curdevice);
		return(1);
	}

	/* Nuts, can't find an lfs livecd anywhere */

	return(0);
}

