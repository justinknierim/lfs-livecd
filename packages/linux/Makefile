# Linux Kernel Makefile

NM= linux
VRS= $(KVERS)
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= fa23a2508a82d17c414adc00cca4557d331a3393

PATCH1= reiser4-for-2.6.12-3.patch.gz
URL-$(PATCH1)= http://ftp.namesys.com/pub/reiser4-for-2.6/2.6.12/$(PATCH1)
SHA-$(PATCH1)= a56513748661db102d75a576d053f6bd78fd2294

PATCH2= squashfs2.2-patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)/

compile-stage2:
ifeq ($(LFS-ARCH),x86)
	if [ ! -d /boot/isolinux ] ; then mkdir /boot/isolinux ; fi
endif
	zcat ../$(PATCH1) > ../reiser4.patch
	patch -Np1 -i ../reiser4.patch
	patch -Np1 -i ../$(PATCH2)
	cd $(ROOT) ; make -C $(PKG)/unionfs patch-kernel
	make mrproper
	cp $(ROOT)/linux/config.$(LFS-ARCH) .config
	make $(PM)
	make modules_install
ifeq ($(LFS-ARCH),x86)
	cp -v arch/i386/boot/bzImage /boot/isolinux/linux
else
	cp -v vmlinux /boot/linux
endif
	cd .. ; ./debian-style-headers.sh linux-$(KVERS)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
