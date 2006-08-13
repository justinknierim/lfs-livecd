# Linux Kernel Makefile

NM= linux
VRS= 2.6.16.27
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
SHA-$(FILE)= ef8635746668d49ba76e799ca681c1b46837e176

# URL_REISER4= http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/broken-out/

PATCH1= reiser4-for-2.6.16-1.patch.gz
URL-$(PATCH1)= http://ftp.namesys.com/pub/reiser4-for-2.6/2.6.16/$(PATCH1)
SHA-$(PATCH1)= 80d0e0530bf658489834dd27ae955e5d89257a98

PATCH3= tulip-is-not-a-proper-driver-for-dm910x.patch

PATCH4= patch-2.6.16-ide1.gz
URL-$(PATCH4)= http://zeniv.linux.org.uk/~alan/IDE/$(PATCH4)
SHA-$(PATCH4)= 573490726a3de61bb2edee2798d83f1350632819

PATCH50= $(NM)-2.6.16.27-utf8_input-1.patch
URL-$(PATCH50)= http://www.linuxfromscratch.org/patches/lfs/6.2/$(PATCH50)
SHA-$(PATCH50)= 1245a73e16a0d6d1b1adfa167bbee2c02ca92dd5

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM)64 $(chbash-post-bash)'

reiser4:
	mkdir reiser4
	-cd reiser4 ; $(WGET) -nc $(URL_REISER4)series
	cd reiser4 ; grep 'reiser4' series | grep -v '#' >reiser4-patches
	-cd reiser4 ; $(WGET) -nc -B $(URL_REISER4) -i reiser4-patches

stage2: Makefile $(FILE) $(PATCH1) $(PATCH3) $(PATCH4) $(PATCH50)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH50)} $(LFSSRC)/

compile-stage2:
ifndef LIBATA_SUFFIX
	zcat ../$(PATCH1) | patch -Np1
#	for a in `cat ../reiser4/reiser4-patches` ; do patch -Np1 -i ../reiser4/$$a ; done
#	echo 'EXPORT_SYMBOL(page_cache_readahead);' >>mm/readahead.c
	patch -Np1 -i ../$(PATCH3)
	zcat ../$(PATCH4) | patch -Np1
	patch -Np1 -l -i ../$(PATCH50)
endif
	make mrproper
	cp ../config.x86_64$(LIBATA_SUFFIX) .config
ifndef LIBATA_SUFFIX
	PATH=$$PATH:$(WD)/bin make ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu-
	PATH=$$PATH:$(WD)/bin make modules_install ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu-
	rm /lib/modules/$(VRS)-64bit/{source,build}
endif
	PATH=$$PATH:$(WD)/bin make bzImage ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu-
	cp -v arch/x86_64/boot/bzImage /boot/isolinux/linux64$(LIBATA_SUFFIX)
ifndef LIBATA_SUFFIX
	make -f ../Makefile compile-stage2 LIBATA_SUFFIX=.ata
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
