# Glibc Makefile

NM= glibc
VRS= 2.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= ec9a007c4875062099a4701ac9137fcdb5a71447

FILE2= $(NM)-libidn-$(VRS).tar.bz2
URL-$(FILE2)= $(HTTP)/$(NM)/$(FILE2)
SHA-$(FILE2)= ee7e019e01aa338e28db1eeb34abb2cb09d2f30a

PATCH1= $(DIR)-branch_update-2.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/development/$(PATCH1)
SHA-$(PATCH1)= e1f19b65f695bdac94245212e3b3f6b5aa18b82c

PATCH50= $(DIR)-supported_locales-1.patch

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(FILE2)
	$(sep_dir_build)

compile-stage1:
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
# --enable-static overrides the unsuitable default in config.site
	../$(DIR)/configure --prefix=$(WD) --disable-profile \
	 --enable-add-ons --enable-kernel=2.6.0 --with-binutils=$(WD)/bin \
	 --without-gd --with-headers=$(WD)/include --without-selinux --enable-static
	make
	# LFS says:
	# mkdir -v /tools/etc
	# We don't do this because Wget created this directory for us
	touch $(WD)/etc/ld.so.conf
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE) $(FILE2) $(PATCH1)
	$(sep_dir_build)
	touch $@

compile-stage2:
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
	cd ../$(DIR) ; unpack ../$(FILE2) ; mv glibc-libidn-$(VRS) libidn
	sed -i \
	's|libs -o|libs -L/usr/lib -Wl,-dynamic-linker=/lib/$(LINKER) -o|' \
	        ../$(DIR)/scripts/test-installation.pl
# LiveCD specific locale additions
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH50)
# --enable-static overrides the unsuitable default in config.site
	sed -i 's|@BASH@|/bin/bash|' elf/ldd.bash.in
	../$(DIR)/configure --prefix=/usr --disable-profile \
	 --enable-add-ons --enable-kernel=2.6.0 --libexecdir=/usr/lib/glibc \
	 --enable-static
	make
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
