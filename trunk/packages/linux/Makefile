# Linux Kernel Makefile

NM= linux
VRS= 2.6.18.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 8a7df3c58179c8a23a36767de2354baa778d3a50

DIR1= loop-AES-v3.1d
FILE1= $(DIR1).tar.bz2
URL-$(FILE1)= http://loop-aes.sourceforge.net/loop-AES/$(FILE1)
SHA-$(FILE1)= 0be0d2e4e70c79a53b2ac6462659c1e36d2e69e6

DIR2= ciphers-v3.0d
FILE2= $(DIR2).tar.bz2
URL-$(FILE2)= http://loop-aes.sourceforge.net/ciphers/$(FILE2)
SHA-$(FILE2)= abdccd258c07729ce1d32843fecccc9228b51cd1

# URL_REISER4= http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/broken-out/

PATCH1= reiser4-for-2.6.18-3.patch.gz
URL-$(PATCH1)= http://ftp.namesys.com/pub/reiser4-for-2.6/2.6.18/$(PATCH1)
SHA-$(PATCH1)= e35fae6d15631f29594076cbc692baeab81d4f69

PATCH3= tulip-is-not-a-proper-driver-for-dm910x.patch

DEPS= $(FILE) $(FILE1) $(FILE2)
DEPS+= $(PATCH1) $(PATCH3)
# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

reiser4:
	mkdir reiser4
	-cd reiser4 ; $(WGET) -nc $(URL_REISER4)series
	cd reiser4 ; grep 'reiser4' series | grep -v '#' >reiser4-patches
	-cd reiser4 ; $(WGET) -nc -B $(URL_REISER4) -i reiser4-patches

stage2: Makefile $(DEPS)
	$(std_build)

compile-stage2:
ifeq ($(LFS-ARCH),x86)
	mkdir -p /boot/isolinux
endif
	unpack ../$(FILE1)
	unpack ../$(FILE2)
	rm -f drivers/block/loop.c include/linux/loop.h
	patch -Np1 -i $(DIR1)/kernel-2.6.16.diff
	zcat ../$(PATCH1) | patch -Np1
#	for a in `cat ../reiser4/reiser4-patches` ; do patch -Np1 -i ../reiser4/$$a ; done
#	echo 'EXPORT_SYMBOL(page_cache_readahead);' >>mm/readahead.c
	patch -Np1 -i ../$(PATCH3)
	make mrproper
	cp ../config.$(LFS-ARCH) .config
	make $(PM)
	make modules_install
	cd $(DIR2) ; unset VERSION ; make LINUX_SOURCE=..
ifeq ($(LFS-ARCH),x86)
	make $(PM) bzImage
	cp -v arch/i386/boot/bzImage /boot/isolinux/linux
endif
ifeq ($(LFS-ARCH),ppc)
	make $(PM) vmlinux
	cp -v vmlinux /boot/linux
endif
	cd .. ; ./debian-style-headers.sh $(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
