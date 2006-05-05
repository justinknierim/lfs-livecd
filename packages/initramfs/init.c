/*
   Init for the Official LFS LiveCD
   Written by Jeremy Huntwork, 2005-09-16

   This code sets up a directory structure for the CD in the initramfs,
   finds and mounts the LFS LiveCD, mounts the root file system via the
   squashfs file, overlays it all with unionfs and finally passes
   control over to sysvinit to finish the boot process.
*/

#include "init.h"


/* Devices to check for the LFS CD, could scan some stuff in /proc in a later version */
const char *devices[] = 
{
	"/dev/hda", "/dev/hdb", "/dev/hdc", "/dev/hdd", "/dev/hde", "/dev/hdf", "/dev/hdg", "/dev/hdh",
	"/dev/sr0", "/dev/sr1", "/dev/sr2", "/dev/sr3", "/dev/sr4", "/dev/sr5", "/dev/sr6", "/dev/sr7",
	NULL,
};

const char *lfscd;

int mountlfscd(void);

int losetup(char * loop, char * file, int flags)
{
	struct loop_info loopinfo;
	int fd, ffd;
	
	memset(&loopinfo, 0, sizeof(loopinfo));

	ffd = open(file, flags);
	if (ffd<0) {
		printf("Failed to open the %s file: %s\n", file, strerror(errno));
		return(0);
	}
	
	fd = open(loop, flags);
	if (fd<0) {
		printf("Failed to open the loop device: %s\n", strerror(errno));
		return(0);
	}

	snprintf(loopinfo.lo_name, LO_NAME_SIZE, "%s", file);

	loopinfo.lo_offset = 0;
	loopinfo.lo_encrypt_key_size = 0;
	loopinfo.lo_encrypt_type = LO_CRYPT_NONE;

	if(ioctl(fd, LOOP_SET_FD, ffd) < 0) {
		printf("Failed to set up device: %s\n", strerror(errno));
		return(0);
	}
	close(ffd);

        if(ioctl(fd, LOOP_SET_STATUS, &loopinfo) < 0) {
                printf("Failed to set up device: %s\n", strerror(errno));
		(void) ioctl(fd, LOOP_CLR_FD, 0);
		close(fd);
                return(0);
        }
        close(fd);
	return(1);
}

int main(int argc, char * argv[], char * envp[])
{
	int i, overhead;
	int fd;
	struct dm_task * dmt;
	struct stat stat_buf;
	
	printf("Initramfs activated\n");

	mkdir("/proc", 0755);
	mount("proc", "/proc", "proc", 0, 0);
	
	mkdir(TMPFS, 0755);
	if (mount("tmpfs", TMPFS, "tmpfs", 0, "size=90%") < 0) {
		printf("Failed to mount tmpfs: %s\n", strerror(errno));
		return (0);
	}
	
	mkdir(CDROM_MOUNT, 0755);

	printf("Searching for the CD named %s...\n", VOLUME_ID);

	for (i=0;i<MAX_RETRIES;i++)
	{
		if (mountlfscd())
			break;

		/* Failed to find any device with an LFS LiveCD */
		printf("I couldn't find an LFS LiveCD in any drive!!\n");
		printf("I'm going to wait 10 seconds and try again (Try %d/%d)\n", i, MAX_RETRIES);
		sleep(10);
	}

	if (i>=MAX_RETRIES)
	{
		printf("I couldn't find an LFS LiveCD in any drive after %d retries!\n", MAX_RETRIES);
		reboot(RB_POWER_OFF);
		return(0);
	}

	/* If we're here, we have the LiveCD mounted and verifieid */
	
	/* Now, attempt to attach the root file to /dev/loop0 */

	printf("Setting up the loopback devices...\n");
	
	losetup("/dev/loop0", ROOT_FILE, O_RDONLY);
	
	/* Create a sparse file for the second loop */
	
	stat(ROOT_FILE, &stat_buf);
	overhead = 0x1000 + stat_buf.st_size / 0x100;
	
	fd = open(OVERLAY, O_CREAT | O_WRONLY, 0600);
	ftruncate(fd, stat_buf.st_size + overhead);
	close(fd);
	
	losetup("/dev/loop1", OVERLAY, O_RDWR);
	
	/* Set up device-mapper */
        dmt = dm_task_create(DM_DEVICE_CREATE);
        dm_task_set_name(dmt, "lfs-cd");
        dm_task_set_major(dmt, 254);
        dm_task_set_minor(dmt, 0);
        dm_task_add_target(dmt, 0, stat_buf.st_size / 0x200,
	    "snapshot", "/dev/loop0 /dev/loop1 p 8");
        dm_task_run(dmt);
        dm_task_destroy(dmt);
							
	printf("Mounting root filesystem...\n");
	mkdir(ROOT, 0755);
	i = mount("/dev/mapper/lfs-cd", ROOT, "ext2", 0, 0);
	if (i<0) {
		printf("Failed to mount root fs: %s\n", strerror(errno));
		return(0);
	}

	/* Move the tmpfs to /dev/shm in the root fs */

	mount("/.tmpfs", ROOT "/dev/shm", NULL, MS_MOVE, NULL);

	/* Create a symlink for the CD drive to /dev/lfs-cd */

	symlink(lfscd, ROOT "/dev/lfs-cd");


	/* Remove the "/init" binary to free some RAM */
	unlink ("/init");
	umount2("/proc", 0);
	
	/* Chroot into the root fs */

	chdir(ROOT);
	mount(".", "/", NULL, MS_MOVE, NULL);

	if ( chroot(".") || chdir("/") )
		return(0);
	
	/* We're done! Pass control to sysvinit. */

	printf("Starting init...\n");
	
	/* FIXME: file descriptors still point to initramfs */
	execve("/sbin/init", argv, envp);
	printf("Failed to start init: %s :(\n", strerror(errno));

	return(0);
}

/* This will look for and mount the LFS LiveCD, if found/mounted it'll return 1, otherwise 0 */
int mountlfscd(void)
{
	struct iso_primary_descriptor pd;
	int i;

	for(i=0;devices[i]!=NULL;i++)
	{
		int fd, status;
		const char *curdevice = devices[i];
		char buf[ISO_BLOCK_SIZE];

		/* Try to open CD drive to see if we can use it */
		fd = open(curdevice, O_RDONLY | O_NONBLOCK);
		if (fd<0)
		{
			/*
				We'll get here if we can't open the device
				(No such device, No such file or directory, etc, etc)
			
			printf("%s: open failed: %s\n", curdevice, strerror(errno)); */
			continue; /* On to the next device!! */
		}

		/* Try to see what the status of the CD drive is */
		status = ioctl(fd, CDROM_DRIVE_STATUS, 0);
		if (status<0)
		{
			/* We'll probably get here if we open a hard disk.
			   No need to always print out this error. */
			/* printf("%s: ioctl failed: %s\n", curdevice, strerror(errno)); */
			close(fd);
			continue; /* On to the next device!! */
		} 

		if (status != CDS_DISC_OK)
		{
			/* We'll probably get here if there's no CD in the drive */
			printf("%s: Drive not ready\n", curdevice);
			close(fd);
			continue; /* On to the next device!! */
		}

		/* If we're here, the cd drive seems to have a disc in it, and is okay! 
		   Now we'll try to match the Volume ID */

		lseek(fd, ISO_PD_BLOCK*ISO_BLOCK_SIZE, SEEK_SET);

		/* Read the ISO Block info and fill a struct with it */

		read(fd, buf, ISO_BLOCK_SIZE);
		memcpy( &pd, buf, sizeof(pd) );

  		printf("%s: Volume ID is %s\n", curdevice, pd.volume_id);

		/* close(fd); */

		/* Compare the string in pd.volume_id with the VOLUME_ID
		   generated by the livecd Makefiles */

		i = strncmp(VOLUME_ID, pd.volume_id, strlen(VOLUME_ID));
		if (i!=0) {
			printf("This is not the correct CD. Moving on...\n");
			close(fd);
			continue;
		}

		/* Try to mount the cd drive*/
		status = mount(curdevice, CDROM_MOUNT, CDROM_FSTYPE, MS_RDONLY, NULL);
		if (status<0)
		{
			printf("%s: mount failed: %s\n", curdevice, strerror(errno));
			close(fd);
			continue; /* On to the next device!! */
		} 

		/* If we're here, we definitely have the LiveCD mounted at the mount point :) */


		memset(buf, 0, 32); /* Clear buffer so we don't have to check read's status */
		read(fd, buf, 10);
		close(fd);

		/* YAY! we have the LFS LiveCD mounted :) */
		printf("%s: LFS LiveCD Verified\n", curdevice);
		lfscd = curdevice;
		return(1);
	}

	/* Nuts, can't find an LFS LiveCD anywhere */

	return(0);
}
