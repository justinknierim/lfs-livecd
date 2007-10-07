Official Linux From Scratch LiveCD
==================================
Version: x86-6.3-r2052


PACKAGES
--------

Available packages on this CD for your use:

 * Xorg (X Window System Environment)

 * Xfce desktop environment

 * Web Tools

   - wget (command line file retriever)
   - curl (command line file retriever)
   - lynx (text web browser)
   - w3m (text web browser)
   - irssi (console irc client)
   - seamonkey (graphical web browser, mail and news reader and irc client)
   - xchat (x-based irc client)
   - pidgin (multiprotocol x-based chat client)
   - finch (multiprotocol console chat client - works in UTF-8 locales only)
   - msmtp (SMTP client for use with mutt and tin)
   - mutt (console email client)
   - tin (console news reader)

 * Text Editors

   - vim
   - nano
   - joe

 * Network Tools

   - SSH server & client
   - NFS server & client
   - Samba server & client
   - Subversion
   - cvs
   - pppd
   - rp-pppoe
   - pptp client
   - dhcpcd
   - ncftp
   - traceroute
   - rsync

 * Filesystem Programs

   - e2fsprogs
   - reiserfsprogs
   - reiser4progs
   - xfsprogs
   - dosfstools
   - ntfsprogs
   - jfsutils

 * Debugging Programs

   - strace

 * Boot Loaders

   - grub
   - lilo

 * Other Programs

   - distcc
   - gpm (console mouse)
   - pciutils
   - mdadm
   - LVM2
   - dmraid
   - kpartx
   - hdparm
   - parted
   - xlockmore

This CD also includes jhalfs (a tool for extracting commands from the Linux From Scratch book and creating
Makefiles that can download, check and build each LFS package for you.)

You can compile other programs from sources directly on the CD. All locations
on the CD can be written to (including '/usr').

VMWARE ISSUE
------------

This CD does not detect virtual SCSI disks connected to a virtual machine in
VMware Workstation 5.x or earlier or VMware Server 1.0.x or earlier. This is
a known VMware bug. The solution is to upgrade to VMware Workstation 6.x, or
to choose 'BusLogic' as the virtual SCSI controller type instead of the
default 'LSI Logic'.

The same issue will be present on an LFS system built from this CD.

CONFIGURING NET CONNECTION
--------------------------

The LiveCD attempts to detect the network cards present in the system.
On each detected network card, dhcpcd is automatically started in the
background. If it is not correct to acquire the network settings via DHCP
in your location, or if you want to use dialup or GPRS connection, run the
'net-setup' command.

If you don't want the CD to start dhcpcd on the detected network cards,
type 'linux nodhcp' at the boot loader prompt. This may be required for
wireless connections that utilize WEP or WPA encryption.

Users of wireless cards based on the Atheros chipset have to install the
proprietary 'madwifi' driver. The driver is provided in the precompiled form
in the '/drivers' directory (if you loaded the CD contents to RAM, you have to
mount the CD and look into '/media/cdrom/drivers' instead). To install it,
run the following commands:

 cd /drivers
 tar -C / -xf madwifi-x86-6.3-r2052-kernel-[kernel_version].tgz
 tar -C / -xf madwifi-x86-6.3-r2052-tools.tgz
 depmod -ae
 modprobe ath_pci

CONFIGURING X
-------------

The LiveCD attempts to configure X for your video card automatically. The
process may fail if you have more than one video card, if your video card
does not support 24-bit color depth, or if your monitor is not Plug-n-Play
compatible (in other words, does not tell its characteristics to Xorg via DDC).
In such cases, you have to edit the '/etc/X11/xorg.conf' file manually, using
vim, joe or nano, as described below.

In 'Section "Device"', specify the driver for your video card, e.g.:

 Section "Device"
 	Identifier      "Generic Video Card"
 	Driver          "vesa"
 EndSection

In 'Section "Monitor"', specify the allowed frequency ranges for your
monitor. If unsure, consult the manual that came with your monitor. If
such information is not there, but you know a working resolution and refresh
rate, run the 'gtf' command. E.g., if your monitor can handle 1280x1024@85Hz:

 $ gtf 1280 1024 85

NOTE: You must specify the refresh rate of 60 Hz for VGA-connected LCD monitors.

Then look at the output:

 # 1280x1024 @ 85.00 Hz (GTF) hsync: 91.38 kHz; pclk: 159.36 MHz
 Modeline "1280x1024_85.00"  159.36  1280 1376 1512 1744  1024 1025 1028 1075 -HSync +Vsync

Put the synchronization ranges that contain the printed values. For the above
example, this means that the following information should be added in the
"Monitor" section:

 Section "Monitor"
 	Identifier	"Generic Monitor"
 	Option		"DPMS"
 	# Option	"NoDDC" # for broken monitors that
 				# report max dot clock = 0 MHz
 	HorizSync	30-92   # because gtf said "hsync: 91.38 kHz"
 	VertRefresh	56-86   # because an 85 Hz mode has been requested
 	# the Modeline may also be pasted here
 	Option "PreferredMode" "1280x1024_85.00" # only for the "intel" driver
 EndSection

In the 'Section "Screen"', change the 'DefaultDepth' and add the '"Modes"'
line to 'SubSection "Display"' with the proper color depth. If you added custom
Modelines, you have to specify them exactly as defined, i.e. '"1280x1024_85.00"'
in the example above. The built-in Modelines have names similar to '"1024x768"',
without explicit specification of the refresh rate.

When you are finished editing '/etc/X11/xorg.conf', run 'startx'.

PROPRIETARY VIDEO DRIVERS
-------------------------

The CD contains pre-built proprietary video drivers in the '/drivers' directory
(if you loaded the CD contents to RAM, you have to mount the CD and look into
'/media/cdrom/drivers' instead). They are never selected by default by the
autoconfiguration process. Here is how to enable them.

NVIDIA
~~~~~~

 cd /drivers
 tar -C / -xf NVIDIA-Linux-[userspace_arch]-x86-6.3-r2052-glx.tgz
 tar -C / -xf NVIDIA-Linux-[kernel_arch]-x86-6.3-r2052-kernel-[kernel_version].tgz
 depmod -ae
 ldconfig
 vim /etc/X11/xorg.conf   # use the "nvidia" driver instead of "vesa" or "nv"

FGLRX
~~~~~

 cd /drivers
 tar -C / -xf fglrx-x710-x86-6.3-r2052-[userspace_arch]-1.tgz
 tar -C / -xf fglrx-module-x86-6.3-r2052-[kernel_arch]-1_kernel_[kernel_version].tgz
 depmod -ae
 ldconfig
 vim /etc/X11/xorg.conf   # use the "fglrx" driver instead of "vesa" or "ati"

CUSTOMIZING THE CD CONTENTS
---------------------------

It is possible to burn a customized version of the official Linux From
Scratch LiveCD, with your own files added. To do that, follow the
instructions in the '/root/lfscd-remastering-howto.txt' file.

AUTOSSHD
--------

It is possible to start the sshd daemon automatically upon boot. To do that,
you have to customize the CD. Create the following files:

'/.autosshd'::
    This is the file that indicates that the sshd daemon should be
    started automatically. It should be empty.

'/root/.ssh/authorized_keys'::
    Add your public key to that file in order to be able to log in.
    Alternatively, modify '/etc/shadow'.

'/etc/shadow'::
    Edit this file if you want to allow root to login using a password via
    ssh. It is more secure to use public key based authentication instead.

'/etc/ssh/ssh_host_dsa_key', '/etc/ssh/ssh_host_rsa_key'::
    Create those files as described in the 'ssh-keygen(1)' manual page. If you
    do not do that, random host keys will be generated for you automatically
    during the boot process. This is less secure, because you cannot verify
    them.

'/etc/sysconfig/network-devices/ifconfig.eth0'::
    Configure a known static IP address there, as described in the LFS book,
    section '7.12. Configuring the network Script'.

INTERNATIONALIZATION
--------------------

It is possible to specify the locale using the bootloader prompt, like this:

 linux LANG=es_ES@euro

The CD tries to guess the proper screen font and keymap based on this
information. If the guess is wrong, you can override it by adding the
following parameters:

KEYMAP::
  specifies the console keymap(s) to load (actually the arguments to
  the 'loadkeys' program separated by the "+" sign), e.g: 'KEYMAP=es+euro1'

LEGACY_CHARSET::
  sometimes a ready-made UTF-8 keymap is not available and
  must be obtained by converting an existing keymap from this charset to UTF-8.
  E.g.: 'LEGACY_CHARSET=iso-8859-15'.
  This parameter is not used in non-UTF-8 locales.

FONT::
  specifies the screen font to set (actually, the arguments to the
  'setfont' program separated by the "+" sign), e.g:
  'FONT=LatArCyrHeb-16+-m+8859-15'

XKEYMAP::
  the keymap to use with X window system, e.g.: 'XKEYMAP=us'

Alternatively, these items can be configured interactively using dialog-based
interface if the locale is not specified on the boot prompt.

For some locales (e.g. 'lv_LV.ISO-8859-13') there is no valid console keymap,
but there is a keymap for X. In this case, the only solution is to use X.

While this CD configures the 'LANG' environment variable, console font and
keymap for you, it is your responsibility to configure other locale-dependent
parameters manually. You have to explicitly specify the 'iocharset' and
'codepage' options when mounting filesystems with Windows origin
(e.g., 'vfat' and 'isofs').

The CD contains TrueType fonts that cover the orthography of most of European
and some Asian languages. No additional configuration is required in order to
use these fonts.

Use of this LiveCD with Chinese, Japanese or Korean language requires that
your monitor has at least 80 pixels per inch in order for hieroglyphs to
be recognizable (i.e., at least 12 pixels high). This means the following
minimum resolution:

.-------.---------
Size    Resolution
------------------
15"     1024x768
17"     1024x768
19"     1280x1024
20"     1280x1024
------------------

If your monitor cannot handle such resolution, edit the
'/etc/X11/xinit/xserverrc' file with vim, nano or joe, and add the '-dpi 94'
parameter to the X server command line there.

BRAILLE DISPLAY SUPPORT
-----------------------

The LiveCD includes the 'brltty' program that allows a blind person to read
the contents of the Linux text console on a Braille display. In order to
activate it, insert the CD into the drive, reboot the computer. Some BIOSes
will produce a beep indicating successful power-on self-testing. If so, the
boot loader will produce a second beep indicating the boot prompt is available.
After that beep (first or second depending on if your computer normally beeps
upon startup), type:

   linux brltty=eu,ttyS0

[NOTE]
This example assumes that the EuroBraille device is connected to the
first serial port. For other device types, the 'brltty' parameter will
be different.

[NOTE]
In some locales, 'brltty' displays incorrect Braille patterns. This is
related to the fact that Braille tables in brltty are indexed with
encoding-dependent bytes representing the character. Such representation
becomes invalid when another encoding for the same language is used.
E.g., that is why the 'ru' table (designed for the KOI8-R encoding) produces
wrong result in the 'ru_RU.CP1251' locale.

Known non-working cases
~~~~~~~~~~~~~~~~~~~~~~~

 * All CP1251-based locales (no CP1251 Braille table in 'brltty')

 * All UTF-8 locales (kernel deficiency)

 * zh_TW (configuration instructions available in Chinese only). If you use
   this locale, please send mail to
   mailto:livecd@linuxfromscratch.org[the LiveCD development list]
   and help us add support for it.

 * All other Chinese, Japanese and Korean locales (no support in 'brltty')

If 'brltty' displays incorrect Braille patterns in your locale, please revert to
the en_US locale, thus avoiding the use of non-ASCII characters. If you know how
to fix this problem for your locale, mail this information to
mailto:livecd@linuxfromscratch.org[the LiveCD development list].

RESUMING THE BUILD
------------------

There is a hint:

http://www.linuxfromscratch.org/hints/downloads/files/stages-stop-and-resume.txt[How to resume your work after a break at different LFS stages]

Instructions from there should work on this CD, however, there is a simpler
method ('hibernation') described below.

Make sure you have (or are planning to create) a swap partition not used
by other Linux systems installed on your hard drive. The text below assumes
that '/dev/hda2' is your (existing or planned) swap partition.

Pass 'resume=/dev/hda2' as one of the kernel arguments when booting this CD.
I.e., the complete boot line may look as:
  
   linux LANG=ru_RU.UTF-8 TZ=Asia/Yekaterinburg resume=/dev/hda2

Alternatively, once the system is running, you can activate hibernation by
echoing the major and minor numbers of the partition to '/sys/power/resume' as
such:

   # ls -l /dev/hda2
   brw-rw---- 1 root disk 3, 2 2006-07-10 17:51 /dev/hda2
   # echo 3:2 >/sys/power/resume

At this point, the system is up and running. If you do not already have a
swap partition, or wish to create a new one, chapter 2 of the LFS book will
show you how to create, format, and activate one.

If you use the X window system, take the following into account:

   * Users of old S3 video cards should uncomment the 'EnableVbetool' line
     in the '/etc/hibernate/common.conf' file.

   * Hibernation is incompatible with the proprietary 'nvidia' driver.

Follow the book as your time permits.

When your time runs out, execute the 'hibernate' command as root. It is not
necessary to stop the compilation, but running this command during a
testsuite may lead to failures that would not occur otherwise.

NOTE: you must unmount all USB flash drives and all partitions used by other
operating systems installed on your computer before hibernating! Do not
attempt to mount partitions used by a hibernated system from other systems
(even read-only, because there is no true read-only mount on journaled
filesystems)!

On some systems, hibernation refuses to work due to a broken ACPI
implementation, with the following message in 'dmesg | tail'  output:

   acpi_pm_prepare does not support 4

Possible solutions:

   a. run the following command before hibernating the computer:

       echo shutdown >/sys/power/disk

   b. disable ACPI completely by adding 'acpi=off' to the kernel arguments.

The computer will save its state to your swap partition and power down.
This CD will remain in the drive.

When you are ready to resume the build, boot this CD again and pass exactly
the same 'vga=...' and 'resume=...' arguments that you used earlier.

The computer will load its state from the swap partition and behave as if
you did not power it off at all (except breaking all network connections).
The build will automatically continue.

The procedure is a bit more complicated if your swap is on an LVM volume
or on software RAID. In this case, instead of passing the 'resume=...' argument,
you should boot the CD as usual and make actions needed for the kernel to see
the swap device (for LVM, that is 'vgchange -ay'). After doing that, note
the major and minor device number for that device (assigning persistent numbers
is highly recommended), and echo them to '/sys/power/resume'. E.g., for LVM:

 # ls -lL /dev/myvg/swap
 brw------- 1 root root 254, 3 2006-07-10 17:51 /dev/myvg/swap
 # echo 254:3 >/sys/power/resume

In the case of the first boot, this will store the device numbers to be used
for hibernation. On the second boot (i.e., after hibernating), this 'echo'
command will restore the computer state from the swap device.

AUTOMATING THE BUILD
--------------------

This CD comes with the 'jhalfs' tool that allows extracting commands from the
XML version of the LFS or CLFS book into Makefiles and shell scripts. You can
find the jhalfs installation in the home directory of the 'jhalfs' user, and the
XML LFS book is in '/usr/share/LFS-BOOK-6.3-XML'. In order to use 'jhalfs',
you have to:

 * create a directory for your future LFS system and mount a partition there

 * change the ownership of that directory to the 'jhalfs' user

 * run 'su - jhalfs' in order to become that user

 * as user 'jhalfs', follow the instructions in the
 '/home/jhalfs/jhalfs-<version>/README' file

Note that this user already has the required root access (via 'sudo') to
complete the build.

LOADING CD CONTENTS TO RAM
--------------------------

The CD works much faster if you load all its contents to RAM. As a bonus, you
will be able to eject the CD immediately and use the CD-ROM drive for other
purposes (e.g., for watching a DVD while compiling LFS).

To load the CD contents to RAM, type 'linux toram' at the boot prompt.

The minimum required amount of RAM is 512 MB. If you have less than 768 MB of
RAM, add swap when the CD boot finishes.

NOTE: in order to save RAM, sources and proprietary drivers are not loaded
there. In order to access them, please mount this CD and look into
'/media/cdrom/sources' and '/media/cdrom/drivers'.

BOOTING FROM ISO IMAGE
----------------------
If you want to boot this CD on a computer without a CD-ROM drive, follow
the steps below.

Store the ISO image of this CD as a file on a partition formatted with
one of the following filesystems:
'vfat', 'ntfs', 'ext2', 'ext3', 'ext4', 'jfs', 'reiserfs', 'reiser4', 'xfs'

Copy the 'boot/isolinux/{linux,initramfs_data.cpio.gz}' files from the CD
to your hard disk

Configure the boot loader to load 'linux' as a kernel image and
'initramfs_data.cpio.gz' as an initrd. The following parameters have to
be passed to the kernel:

   rw root=iso:/dev/XXX:/path/to/lfslivecd.iso rootfstype=fs_type

where '/dev/XXX' is a partition where you stored the LiveCD image, and
'fs_type' is the type of the filesystem on that partition. You may
also want to add 'rootflags=...' option if mounting this partition requires
special flags.

If there is only Windows on the target computer, please use grub4dos as a boot
loader. It is available from
http://sourceforge.net/projects/grub4dos[grub4dos project page].

MAKING A BOOTABLE USB DRIVE
---------------------------

Install GRUB on a flash drive, then follow instructions in the
"BOOTING FROM ISO IMAGE" above, using a partition on your flash drive.
The following tips will ensure that the flash drive is bootable in any
computer:

 * Use the persistent symlink such as '/dev/disk/by-uuid/890C-F46A' to identify
   the target partition.

 * Add 'rootdelay=20' to the kernel arguments.

THANKS
------

Many thanks to all whose suggestions, support and hard work have helped create
this CD.
