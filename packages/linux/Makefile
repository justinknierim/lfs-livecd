# Linux Kernel Makefile

# Package versions
NM= linux
VRS= 2.6.10
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
FILE1= $(PATCH2).gz
PATCH1= $(DIR)-security_fix-1.patch
PATCH2= reiser4-for-2.6.10-1
PATCH3= squashfs2.1-patch 
URL= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
URL1= http://www.linuxfromscratch.org/patches/lfs/cvs/testing/$(PATCH1)
URL2= http://ftp.namesys.com/pub/reiser4-for-2.6/$(VRS)/$(FILE1)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH1) ] ; then $(WGET) $(URL1) && mv $(PATCH1) $(SRC) ; fi
	@if [ ! -f $(PATCH2) ] ; then $(WGET) $(URL2) && gunzip $(FILE1) ; fi
	@if [ ! -f /boot/isolinux/linux ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH1) && \
	 patch -Np1 -i ../$(PATCH2) && \
	 patch -Np1 -i $(ROOT)/$(PKG)/squashfs/squashfs2.1/linux-2.6.9/$(PATCH3) && \
	 make mrproper && \
	 sed -i 's@/sbin/hotplug@/bin/true@' kernel/kmod.c && \
	 cp $(ROOT)/linux/config .config && \
	 make -j3 && \
	 make modules_install && \
	 cd $(ROOT)/initramfs && make && \
	 cp initramfs_data.cpio.gz $(ROOT)/$(PKG)/$(NM)/$(DIR)/usr/ && \
	 cd $(ROOT)/$(PKG)/$(NM)/$(DIR) && \
	 make ; fi
	@-mkdir /boot/isolinux
	@-cp $(DIR)/arch/i386/boot/bzImage /boot/isolinux/linux

clean:
	@-rm -rf $(DIR)
