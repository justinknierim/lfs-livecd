#include <sys/mount.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <sys/stat.h>
#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <linux/cdrom.h>

const char *Proc = "proc";
const char *Sys = "sysfs";
const char *Dev = "ramfs";

const char *ProcPoint = "/proc";
const char *SysPoint = "/sys";
const char *DevPoint = "/dev";

const char *drive[] = {  "/dev/hda",
			 "/dev/hdb",
			 "/dev/hdc",
                         "/dev/hdd",
                         "/dev/hde",
                         "/dev/hdf",
                         "/dev/hdg",
                         "/dev/hdh",
			 "/dev/sr0",
			 "/dev/sr1",
			 "/dev/sr2",
			 "/dev/sr3",
			 "/dev/sr4",
			 "/dev/sr5",
			 "/dev/sr6",
			 "/dev/sr7",

};

const char *Var[] = { "var",
			"var/cache",
			"var/empty",
			"var/lib",
			"var/local",
			"var/lock",
			"var/log",
			"var/mail",
			"var/opt",
			"var/run",
			"var/spool",
			"var/lib/locate",
			"var/lib/misc",
			"var/lib/nfs",
			"var/lib/xkb",
			"var/lib/xdm"
};

#define MAX_INIT_ARGS 8
#define MAX_INIT_ENVS 8

char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };

const char *ProcIde = "/proc/ide/";
const char *Media   = "/media";
const char *Device  = "/dev/";
const char *CDrom   = "/.cdrom";
const char *ISO     = "iso9660";
const char *LFS     = "/LFS";
const char *Mine    = "LFS-6.0-TP-CD";
const char *CDlib   = "/.cdrom/lib";
const char *Lib     = "lib";
const char *CDusr   = "/.cdrom/usr";
const char *Usr     = "usr";
const char *CDsbin  = "/.cdrom/sbin";
const char *Sbin    = "sbin";
const char *CDbin   = "/.cdrom/bin";
const char *Bin     = "bin";

char FileName[24];
char MyFile[24];
char Buffer[32];
char Mount[8];

pid_t Child;
int reply,i,File,fd,status;

static void run_init_process(char *init_filename)
{
  argv_init[0] = init_filename;
  execve(init_filename, argv_init, envp_init);
}


int main(void)
{

  printf("Initramfs activated\n");

  mkdir( ProcPoint, 755);
  printf("Mounting proc...\n");
  reply =  mount( Proc, ProcPoint, Proc, 0, 0);

  mkdir( SysPoint, 755);
  printf("Mounting sys...\n");
  reply =  mount( Sys, SysPoint, Sys, 0, 0);


  mkdir ( CDrom, 755 );
  
  printf("Attempting to find CD\n");
  for (i=0; i < 16; i++)
    {
      fd = open(drive[i], O_RDONLY | O_NONBLOCK);
      if (fd > 0)
	{
	  status = ioctl (fd, CDROM_DRIVE_STATUS, 0);
	  if (status > 0)
	    { 
	      switch(status)
		{
		   case CDS_DISC_OK:
			printf("%s: Disc present.\n", drive[i]);
			printf("Reading disc...");
			mount(drive[i], CDrom, ISO, MS_RDONLY, 0);
			memcpy(MyFile, CDrom, 7);
			memcpy(&MyFile[7], LFS, 4);
			printf("Looking for %s\n", MyFile);
			File = open(MyFile, O_RDONLY);
			if (File > 0)
			{
			  read(File, Buffer, 13);
			  close(File);
			  if ( !strncmp(Buffer, Mine, 13))
			    {
			      printf("LFS CD Verified\nBuilding Directory Structure...\n");
			      mkdir("tmp", 1777);
			      mkdir("root", 1750);
			      for (i=0; i<16; i++)
				{
					mkdir(Var[i], 755);
				}
			      symlink(CDbin, Bin);
			      symlink(CDlib, Lib);
			      symlink(CDsbin, Sbin);
			      symlink("/.cdrom/etc", "etc");
			      symlink("/.cdrom/boot", "boot");
			      printf("Populating /dev with device nodes...\n");
			      mount("none", "/dev", "ramfs", 0, 0);
			      system("/sbin/udevstart");
			      symlink("/proc/self/fd", "/dev/fd");
			      symlink("/proc/self/fd/0", "/dev/stdin");
			      symlink("/proc/self/fd/1", "/dev/stdout");
			      symlink("/proc/self/fd/2", "/dev/stderr");
			      symlink("/proc/kcore", "/dev/core");
			      mkdir("/dev/pts", 0755);
			      mkdir("/dev/shm", 1777);
			      printf("Mounting /dev/pts and /dev/shm...\n");
			      mount("none", "/dev/pts", "devpts", 0, "gid=4,mode=620");
			      mount("none", "/dev/shm", "tmpfs", 0, 0);
			      run_init_process("/sbin/init");
			      break;
			    }
			}
		   default:
			printf(drive[i], ": Drive not ready.\n");
		}
	    }
	}
    }
  return(0);
}
