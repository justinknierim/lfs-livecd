# Makefile for initramfs included on the LFS livecd
# Written by Jeremy Huntwork, 2004-12-16
#

all: initramfs_data.cpio.gz
MK= mknod
CP= cp
WD= temp
KLIBC= /usr/lib/klibc

initramfs_data.cpio.gz: init
	@make -C .. ch-klibc
	@make -C .. ch-unionfs
	mkdir -p $(WD)/{dev,bin,lib,.cdrom,.sqfs,.tmpfs,.union}
	$(CP) $(KLIBC)/bin/{insmod,isoinfo,losetup,mount,run-init,sh,sleep} $(WD)/bin
	$(CP) $(KLIBC)/lib/klibc-*.so $(WD)/lib
	$(CP) /lib/modules/$(KVERS)/kernel/fs/unionfs.ko $(WD)/lib
	$(CP) init $(WD)
	$(MK) -m 640 $(WD)/dev/console c 5 1
	$(MK) -m 660 $(WD)/dev/hda b 3 0
	$(MK) -m 660 $(WD)/dev/hdb b 3 64
	$(MK) -m 660 $(WD)/dev/hdc b 22 0
	$(MK) -m 660 $(WD)/dev/hdd b 22 64
	$(MK) -m 660 $(WD)/dev/hde b 33 0
	$(MK) -m 660 $(WD)/dev/hdf b 33 64
	$(MK) -m 660 $(WD)/dev/hdg b 34 0
	$(MK) -m 660 $(WD)/dev/hdh b 34 64
	$(MK) -m 664 $(WD)/dev/null c 1 3
	$(MK) -m 660 $(WD)/dev/sr0 b 11 0
	$(MK) -m 660 $(WD)/dev/sr1 b 11 1
	$(MK) -m 660 $(WD)/dev/sr2 b 11 2
	$(MK) -m 660 $(WD)/dev/sr3 b 11 3
	$(MK) -m 660 $(WD)/dev/sr4 b 11 4
	$(MK) -m 660 $(WD)/dev/sr5 b 11 5
	$(MK) -m 660 $(WD)/dev/sr6 b 11 6
	$(MK) -m 660 $(WD)/dev/sr7 b 11 7
	$(MK) -m 660 $(WD)/dev/loop0 b 7 0
	cd $(WD); find . | cpio -o -H newc | gzip -9 > ../initramfs_data.cpio.gz
	rm -rf temp

clean:
	-rm -rf temp
	-rm -f initramfs_data*
