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

PATCH50= $(DIR)-supported_locales-1.patch

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(FILE2)
	$(sep_dir_build)
	cp $(SRC)/{$(FILE),$(FILE2)} $(LFSSRC)/

compile-stage1:
# --enable-static overrides the unsuitable default in config.site
	../$(DIR)/configure --prefix=$(WD) --disable-profile \
	 --enable-add-ons --enable-kernel=2.6.0 --with-binutils=$(WD)/bin \
	 --without-gd --with-headers=$(WD)/include --without-selinux --enable-static
	PARALLELMFLAGS="$(PM)" make
	# LFS says:
	# mkdir -v /tools/etc
	# We don't do this because Wget created this directory for us
	touch $(WD)/etc/ld.so.conf
	PARALLELMFLAGS="$(PM)" make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE) $(FILE2) $(PATCH1) $(PATCH2)
	$(sep_dir_build)
	touch $@

compile-stage2:
	cd ../$(DIR) ; unpack ../$(FILE2) ; mv glibc-libidn-$(VRS) libidn
# The vi_VN.TCVN locale doesn't work, testcase: "LC_ALL=vi_VN.TCVN bash"
# Result: the prompt never comes back, CPU utilization is 100%
# (This may be a bash bug. Not reproducible on Debian Etch, though)
	sed -i '/vi_VN.TCVN/d' ../$(DIR)/localedata/SUPPORTED
	sed -i \
	's|libs -o|libs -L/usr/lib -Wl,-dynamic-linker=/lib/$(LINKER) -o|' \
	        ../$(DIR)/scripts/test-installation.pl
# LiveCD specific locale additions
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH50)
# --enable-static overrides the unsuitable default in config.site
	../$(DIR)/configure --prefix=/usr --disable-profile \
	 --enable-add-ons --enable-kernel=2.6.0 --libexecdir=/usr/lib/glibc --enable-static
	PARALLELMFLAGS="$(PM)" make
	-make -k check
	touch /etc/ld.so.conf
	PARALLELMFLAGS="$(PM)" make install
	PARALLELMFLAGS="$(PM)" make localedata/install-locales
	cp $(ROOT)/etc/nsswitch.conf /etc
	cp --remove-destination /usr/share/zoneinfo/$(timezone) /etc/localtime
	cp $(ROOT)/etc/ld.so.conf /etc

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-stage1 clean chroot compile-stage2
