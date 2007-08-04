# Glibc Makefile

NM= glibc
VRS= 2.5.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/gnu/glibc/$(FILE)
SHA-$(FILE)= 2b7da136df025bb8c787be3351cba58374226d9c

FILE2= $(NM)-libidn-$(VRS).tar.gz
URL-$(FILE2)= http://ftp.gnu.org/gnu/glibc/$(FILE2)
SHA-$(FILE2)= 816f410835a8d4ecbccdfed2d86ccc6284c2fa92

PATCH50= $(DIR)-supported_locales-1.patch

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(FILE2)
	$(sep_dir_build)

compile-stage1:
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

stage2: $(FILE) $(FILE2)
	$(sep_dir_build)
	touch $@

compile-stage2:
	cd ../$(DIR) ; unpack ../$(FILE2) ; mv glibc-libidn-$(VRS) libidn
	sed -i \
	's|libs -o|libs -L/usr/lib -Wl,-dynamic-linker=/lib/$(LINKER) -o|' \
	        ../$(DIR)/scripts/test-installation.pl
# LiveCD specific locale additions
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH50)
# --enable-static overrides the unsuitable default in config.site
	sed -i 's|@BASH@|/bin/bash|' ../$(DIR)/elf/ldd.bash.in
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
