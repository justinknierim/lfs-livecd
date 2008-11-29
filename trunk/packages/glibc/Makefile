# Glibc Makefile

NM= glibc
VRS= 2.8-20080929
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 9f2ad5f67bd484d390b33593ce4b613da8c260bd

PATCH1= $(DIR)-iconv_tests-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 90ad8b8d76f3eaa02f789d50df50d1e7d3520a48

PATCH2= $(DIR)-ildoubl_test-1.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 038597c7001fed849863b467f25499058baa7191

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(sep_dir_build)

compile-stage1:
	cd ../$(DIR) ; sed -i 's@/etc/ld.so.preload@/tools/etc/ld.so.preload@' elf/rtld.c
	echo "CFLAGS += -march=i486 -mtune=native" > configparms
	../$(DIR)/configure --prefix=$(WD) --disable-profile \
	 --enable-add-ons --enable-kernel=2.6.0 --with-binutils=$(WD)/bin \
	 --without-gd --with-headers=$(WD)/include --without-selinux
	make
	# LFS says:
	# mkdir -v /tools/etc
	# We don't do this because Wget created this directory for us
	touch $(WD)/etc/ld.so.conf
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE) $(PATCH1) $(PATCH2)
	$(sep_dir_build)
	touch $@

compile-stage2:
	cd ../$(DIR) ; sed -i '/vi_VN.TCVN/d' localedata/SUPPORTED
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH2)
	cd ../$(DIR) ; sed -i 's|@BASH@|/bin/bash|' elf/ldd.bash.in 
	echo "CFLAGS += -march=i486 -mtune=native" > configparms
	../$(DIR)/configure --prefix=/usr --disable-profile \
	 --enable-add-ons --enable-kernel=2.6.0 --libexecdir=/usr/lib/glibc
	make
	cp -v ../$(DIR)/iconvdata/gconv-modules iconvdata
	-make -k check
	touch /etc/ld.so.conf
	make install
	make localedata/install-locales
	cp $(ROOT)/etc/nsswitch.conf /etc
	cp --remove-destination /usr/share/zoneinfo/$(timezone) /etc/localtime
	cp $(ROOT)/etc/ld.so.conf /etc

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-stage1 clean chroot compile-stage2
