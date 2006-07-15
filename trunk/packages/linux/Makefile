# Linux Kernel Makefile

NM= linux
VRS= 2.6.16.25
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
SHA-$(FILE)= edfe884401c74814d2b450aa0020ad5d24ad8cbb

# URL_REISER4= http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/broken-out/

PATCH1= reiser4-for-2.6.16-1.patch.gz
URL-$(PATCH1)= http://ftp.namesys.com/pub/reiser4-for-2.6/2.6.16/$(PATCH1)
SHA-$(PATCH1)= 80d0e0530bf658489834dd27ae955e5d89257a98

PATCH3= tulip-is-not-a-proper-driver-for-dm910x.patch

PATCH4= patch-2.6.16-ide1.gz
URL-$(PATCH4)= http://zeniv.linux.org.uk/~alan/IDE/$(PATCH4)
SHA-$(PATCH4)= 573490726a3de61bb2edee2798d83f1350632819

PATCH50= $(NM)-2.6.16-utf8_input-1.patch
URL-$(PATCH50)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH50)
SHA-$(PATCH50)= 1245a73e16a0d6d1b1adfa167bbee2c02ca92dd5

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

stage2: Makefile $(FILE) $(PATCH1) $(PATCH3) $(PATCH4) $(PATCH50)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH50)} $(LFSSRC)/

compile-stage2:
ifeq ($(LFS-ARCH),x86)
	mkdir -p /boot/isolinux
endif
ifndef LIBATA_SUFFIX
	zcat ../$(PATCH1) | patch -Np1
#	for a in `cat ../reiser4/reiser4-patches` ; do patch -Np1 -i ../reiser4/$$a ; done
#	echo 'EXPORT_SYMBOL(page_cache_readahead);' >>mm/readahead.c
	patch -Np1 -i ../$(PATCH3)
	zcat ../$(PATCH4) | patch -Np1
	patch -Np1 -l -i ../$(PATCH50)
endif
	make mrproper
	cp ../config.$(LFS-ARCH)$(LIBATA_SUFFIX) .config
ifndef LIBATA_SUFFIX
	make $(PM)
	make modules_install
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
	cd .. ; ./debian-style-headers.sh linux-$(VRS)
	make -f ../Makefile compile-stage2 LIBATA_SUFFIX=.ata
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
