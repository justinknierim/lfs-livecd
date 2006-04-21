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
#include <linux/loop.h>
#include <linux/cdrom.h>
#include <linux/fs.h>
#include <sys/reboot.h>
#include <libdevmapper.h>
#include "iso9660.h"

#define TMPFS		"/.tmpfs"		  	/* Mount point for tmpfs */
#define CDROM_MOUNT	"/.tmpfs/.cdrom"		/* Mount point for CD */
#define ROOT_FILE	"/.tmpfs/.cdrom/root.ext2"	/* Origin file for the root fs */
#define ROOT		"/.root"			/* Mount point for the root fs */
#define OVERLAY		"/.tmpfs/.overlay"		/* Full path to overlay */

#define	ISO_BLOCK_SIZE	2048
#define	ISO_PD_BLOCK	0x10

#define CDROM_FSTYPE	"iso9660"           	/* Filesystem of CD */
#define MAX_RETRIES	3                   	/* How many times to retry scanning for the CD */
