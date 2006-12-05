# Linux Kernel Makefile

NM= linux
VRS= 2.6.16.27
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
SHA-$(FILE)= ef8635746668d49ba76e799ca681c1b46837e176

DIR1= loop-AES-v3.1d
FILE1= $(DIR1).tar.bz2
URL-$(FILE1)= http://loop-aes.sourceforge.net/loop-AES/$(FILE1)
SHA-$(FILE1)= 0be0d2e4e70c79a53b2ac6462659c1e36d2e69e6

DIR2= ciphers-v3.0d
FILE2= $(DIR2).tar.bz2
URL-$(FILE2)= http://loop-aes.sourceforge.net/ciphers/$(FILE2)
SHA-$(FILE2)= abdccd258c07729ce1d32843fecccc9228b51cd1

# URL_REISER4= http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/broken-out/

PATCH028= patch-2.6.16.27-28.bz2
URL-$(PATCH028)= http://www.kernel.org/pub/linux/kernel/v2.6/incr/$(PATCH028)
SHA-$(PATCH028)= 4b81b7f235f5abeb4cba684abcacdb338c2cff9f

PATCH029= patch-2.6.16.28-29.bz2
URL-$(PATCH029)= http://www.kernel.org/pub/linux/kernel/v2.6/incr/$(PATCH029)
SHA-$(PATCH029)= afdbe88bafec3d2820a00b85e85a6ea2e71ec97b

PATCH1= reiser4-for-2.6.16-1.patch.gz
URL-$(PATCH1)= http://ftp.namesys.com/pub/reiser4-for-2.6/2.6.16/$(PATCH1)
SHA-$(PATCH1)= 80d0e0530bf658489834dd27ae955e5d89257a98

PATCH3= tulip-is-not-a-proper-driver-for-dm910x.patch

PATCH4= patch-2.6.16-ide1.gz
URL-$(PATCH4)= http://zeniv.linux.org.uk/~alan/IDE/$(PATCH4)
SHA-$(PATCH4)= 573490726a3de61bb2edee2798d83f1350632819

PATCH5= sym2-claim-only-Storage-class.patch

PATCH50= $(NM)-2.6.16.27-utf8_input-1.patch
URL-$(PATCH50)= http://www.linuxfromscratch.org/patches/lfs/6.2/$(PATCH50)
SHA-$(PATCH50)= 1245a73e16a0d6d1b1adfa167bbee2c02ca92dd5

DEPS= $(FILE) $(FILE1) $(FILE2) $(PATCH028) $(PATCH029)
DEPS+= $(PATCH1) $(PATCH3) $(PATCH4) $(PATCH50)
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
	cp $(SRC)/{$(FILE),$(PATCH028),$(PATCH029),$(PATCH50)} $(LFSSRC)/

compile-stage2:
ifeq ($(LFS-ARCH),x86)
	mkdir -p /boot/isolinux
endif
ifndef LIBATA_SUFFIX
	unpack ../$(FILE1)
	unpack ../$(FILE2)
	rm -f drivers/block/loop.c include/linux/loop.h
	patch -Np1 -i $(DIR1)/kernel-2.6.16.diff
	bzcat ../$(PATCH028) | patch -Np1
	bzcat ../$(PATCH029) | patch -Np1
	zcat ../$(PATCH1) | patch -Np1
#	for a in `cat ../reiser4/reiser4-patches` ; do patch -Np1 -i ../reiser4/$$a ; done
#	echo 'EXPORT_SYMBOL(page_cache_readahead);' >>mm/readahead.c
	patch -Np1 -i ../$(PATCH3)
	zcat ../$(PATCH4) | patch -Np1
	patch -Np1 -i ../$(PATCH5)
	patch -Np1 -i ../$(PATCH50)
endif
	make mrproper
	cp ../config.$(LFS-ARCH)$(LIBATA_SUFFIX) .config
ifndef LIBATA_SUFFIX
	make $(PM)
	make modules_install
	cd $(DIR2) ; unset VERSION ; make LINUX_SOURCE=..
endif
ifeq ($(LFS-ARCH),x86)
	make $(PM) bzImage
	cp -v arch/i386/boot/bzImage /boot/isolinux/linux$(LIBATA_SUFFIX)
endif
ifeq ($(LFS-ARCH),ppc)
	make $(PM) vmlinux
	cp -v vmlinux /boot/linux$(LIBATA_SUFFIX)
endif
ifndef LIBATA_SUFFIX
	cd .. ; ./debian-style-headers.sh $(DIR)
	make -f ../Makefile compile-stage2 LIBATA_SUFFIX=.ata
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
