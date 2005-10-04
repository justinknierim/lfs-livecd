# Makefile for initramfs included on the LFS livecd

NM= initramfs
VRS= 1

MK= mknod
CP= cp
WDIR= temp

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile
	make compile-$@

compile-stage2: init
	mkdir -p $(WDIR)/{dev,bin,.tmpfs,.union}
	$(CP) init $(WDIR)/
	$(MK) -m 640 $(WDIR)/dev/console c 5 1
	$(MK) -m 660 $(WDIR)/dev/hda b 3 0
	$(MK) -m 660 $(WDIR)/dev/hdb b 3 64
	$(MK) -m 660 $(WDIR)/dev/hdc b 22 0
	$(MK) -m 660 $(WDIR)/dev/hdd b 22 64
	$(MK) -m 660 $(WDIR)/dev/hde b 33 0
	$(MK) -m 660 $(WDIR)/dev/hdf b 33 64
	$(MK) -m 660 $(WDIR)/dev/hdg b 34 0
	$(MK) -m 660 $(WDIR)/dev/hdh b 34 64
	$(MK) -m 664 $(WDIR)/dev/null c 1 3
	$(MK) -m 660 $(WDIR)/dev/sr0 b 11 0
	$(MK) -m 660 $(WDIR)/dev/sr1 b 11 1
	$(MK) -m 660 $(WDIR)/dev/sr2 b 11 2
	$(MK) -m 660 $(WDIR)/dev/sr3 b 11 3
	$(MK) -m 660 $(WDIR)/dev/sr4 b 11 4
	$(MK) -m 660 $(WDIR)/dev/sr5 b 11 5
	$(MK) -m 660 $(WDIR)/dev/sr6 b 11 6
	$(MK) -m 660 $(WDIR)/dev/sr7 b 11 7
	$(MK) -m 660 $(WDIR)/dev/loop0 b 7 0
	cd $(WDIR); find . | cpio -o -H newc | gzip -9 > ../initramfs_data.cpio.gz
ifeq ($(LFS-ARCH),x86)
	$(CP) initramfs_data.cpio.gz /boot/isolinux/initramfs_data_cpio.gz
else
	$(CP) initramfs_data.cpio.gz /boot/
endif
	rm -rf temp

init:
	gcc $@.c -o $@ -static -Os -s -Wall -DVOLUME_ID=\"lfslivecd-$(VERSION)\"

clean:
	-rm -rf temp
	-rm -f initramfs_data*
	-rm -f init

.PHONY: clean chroot compile-stage2
