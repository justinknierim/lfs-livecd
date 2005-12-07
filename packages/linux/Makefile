# Linux Kernel Makefile

NM= linux
VRS= $(KVERS)
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2

ifneq ($(LFS-ARCH),sparc64)
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= fa23a2508a82d17c414adc00cca4557d331a3393

PATCH1= reiser4-for-2.6.12-3.patch.gz
URL-$(PATCH1)= http://ftp.namesys.com/pub/reiser4-for-2.6/2.6.12/$(PATCH1)
SHA-$(PATCH1)= a56513748661db102d75a576d053f6bd78fd2294
else
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
SHA-$(FILE)= 735bd87eceacba9024b134d7c35f38fd18ef161b

PATCH1= reiser4-for-2.6.13-2.broken-out.tar.gz
URL-$(PATCH1)= http://ftp.namesys.com/pub/reiser4-for-2.6/2.6.13/$(PATCH1)
SHA-$(PATCH1)= a458ccc431d8835edc89cc09f8188b8d880fd263
endif

PATCH2= squashfs2.2-patch

PATCH50= $(NM)-2.6.12.5-utf8_input-2.patch
URL-$(PATCH50)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH50)
SHA-$(PATCH50)= 72b51b7cf6b5eeecf79a07d3778670c64011397c

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
ifneq ($(LFS-ARCH),sparc64)
	zcat ../$(PATCH1) > ../reiser4.patch
	patch -Np1 -i ../reiser4.patch
else
	unpack ../$(PATCH1)
	for i in `cat broken-out/serie` ; do \
	  patch -Np1 -i broken-out/$$i.patch ; \
	done
endif
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
