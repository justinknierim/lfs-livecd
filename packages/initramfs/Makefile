# Makefile for initramfs included on the LFS livecd

NM= initramfs
VRS= 1

WDIR= temp

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile init.in
	@make compile-$@
	@make clean
	@touch $@

compile-stage2:
	mkdir -p $(WDIR)/{bin,dev,etc/udev/rules.d,lib/firmware,sbin,sys,proc}
	cp /etc/udev/udev.conf $(WDIR)/etc/udev/udev.conf
	cp /etc/udev/rules.d/{05-*,2*,60-*} $(WDIR)/etc/udev/rules.d
	sed -i 's/, *GROUP="[^"]*"//' $(WDIR)/etc/udev/rules.d/*
	sed s/@VERSION@/$(VERSION)/ init.in >$(WDIR)/init
	chmod 755 $(WDIR)/init
	cp fakecd.iso.head $(WDIR)
	mknod -m 640 $(WDIR)/dev/console c 5 1
	mknod -m 664 $(WDIR)/dev/null c 1 3
	cp /bin/{sh,dd,cat,cp,killall,mkdir,mount,umount,sed,sleep,ln,rm,uname} $(WDIR)/bin
	cp /lib/{libblkid.so.1,libc.so.6,libdl.so.2,ld-linux.so.2} $(WDIR)/lib
	cp /lib/{libncursesw.so.5,libreadline.so.5,libhistory.so.5} $(WDIR)/lib
	cp /lib/{libpthread.so.0,librt.so.1,libuuid.so.1} $(WDIR)/lib
	cp /lib/{libvolume_id.so.0,libsysfs.so.2} $(WDIR)/lib
	cp /usr/lib/libdevmapper.so.1.02 $(WDIR)/lib
	cp -a /lib/udev $(WDIR)/lib
	cp -a /lib/firmware/{aic94xx-seq.fw,ql*.bin} $(WDIR)/lib/firmware
	cp /sbin/{losetup,blockdev,udevd,udevtrigger,udevsettle,modprobe} $(WDIR)/sbin
	cp /sbin/pcmcia-{check-broken-cis,socket-startup} $(WDIR)/sbin
	cp /usr/bin/stat $(WDIR)/bin
	cp /usr/sbin/dmsetup $(WDIR)/sbin
	find /lib/modules/*/kernel/drivers/{ata,base,block,cdrom,ide,ieee1394,firewire,hid,message,scsi,pcmcia,usb/{core,host,storage}} \
	    /lib/modules/*/kernel/fs/{mbcache.ko,ext2,ext3,ext4,jbd,jbd2,reiserfs,reiser4,xfs,fat,vfat,ntfs,isofs,udf,nls} \
	    /lib/modules/*/kernel/lib -type f | cpio --make-directories -p $(WDIR)
	for a in /lib/modules/* ; do ver=$${a##*/} ; depmod -b $(WDIR) $$ver ; done
	cd $(WDIR); find . | cpio -o -H newc | gzip -9 > ../initramfs_data.cpio.gz
	cp initramfs_data.cpio.gz /boot/isolinux/initramfs_data.cpio.gz
	rm -rf $(WDIR)

clean:
	-rm -rf $(WDIR)
	-rm -f initramfs_data*

.PHONY: clean chroot compile-stage2
