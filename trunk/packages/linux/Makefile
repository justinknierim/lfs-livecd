# Linux Kernel Makefile

# Package versions
NM= linux
VRS= $(KVERS)
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH1= squashfs2.1-patch
PATCH2= $(DIR)-reiser4_missing_export-1.patch
URL= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
URL1= http://ftp.namesys.com/pub/reiser4-for-2.6/2.6.11/broken-out

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && mv $(FILE) $(SRC) ; fi
	@if [ ! -f /boot/isolinux/linux ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 $(WGET) $(URL1).1/serie && \
	 for i in `cat serie` ; do $(WGET) $(URL1).2/$$i && \
	 mv $$i ../ && patch -Np1 -i ../$$i ; done && \
	 patch -Np1 -i $(ROOT)/$(PKG)/squashfs/squashfs2.1/linux-2.6.9/$(PATCH1) && \
	 make mrproper && \
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
