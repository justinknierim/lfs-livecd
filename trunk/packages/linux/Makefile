# Linux Kernel Makefile

NM= linux
VRS= $(KVERS)
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
ifndef CROSS
SHA-$(FILE)= fa23a2508a82d17c414adc00cca4557d331a3393

PATCH1= reiser4-for-2.6.12-3.patch.gz
URL-$(PATCH1)= http://ftp.namesys.com/pub/reiser4-for-2.6/2.6.12/$(PATCH1)
SHA-$(PATCH1)= a56513748661db102d75a576d053f6bd78fd2294

PATCH50= $(NM)-2.6.12.5-utf8_input-2.patch
URL-$(PATCH50)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH50)
SHA-$(PATCH50)= 72b51b7cf6b5eeecf79a07d3778670c64011397c

else
SHA-$(FILE)= b3700f5b923446f9c8f1beda914e1b0f65d8349e

PATCH1= reiser4-for-2.6.14-1.patch.gz
URL-$(PATCH1)= http://ftp.namesys.com/pub/reiser4-for-2.6/2.6.14/$(PATCH1)
SHA-$(PATCH1)= 1d44c6bd6cb14ae35cdea973510c8608bd557f39

PATCH50= $(NM)-2.6.14-utf8_input-1.patch
URL-$(PATCH50)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH50)
SHA-$(PATCH50)= 691a781c8233bcba9457bddbe3b7362bf7f663f7
endif

PATCH2= squashfs2.2-patch


# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH50)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH50)} $(LFSSRC)/

compile-stage2:
ifeq ($(LFS-ARCH),x86)
	if [ ! -d /boot/isolinux ] ; then mkdir /boot/isolinux ; fi
endif
ifeq ($(LFS-ARCH),x86_64)
	if [ ! -d /boot/isolinux ] ; then mkdir /boot/isolinux ; fi
endif
	zcat ../$(PATCH1) > ../reiser4.patch
	patch -Np1 -i ../reiser4.patch
	patch -Np1 -i ../$(PATCH2)
	cd $(ROOT) ; make -C $(PKG)/unionfs patch-kernel
	patch -Np1 -i ../$(PATCH50)
	make mrproper
	cp ../config.$(LFS-ARCH) .config
	make $(PM)
	make modules_install
ifeq ($(LFS-ARCH),x86)
	cp -v arch/i386/boot/bzImage /boot/isolinux/linux
endif
ifeq ($(LFS-ARCH),x86_64)
	cp -v arch/x86_64/boot/bzImage /boot/isolinux/linux
endif
ifeq ($(LFS-ARCH),ppc)
	cp -v vmlinux /boot/linux
endif
ifeq ($(LFS-ARCH),sparc64)
	cp -v arch/sparc64/boot/image /boot/linux
endif
	cd .. ; ./debian-style-headers.sh linux-$(KVERS)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
