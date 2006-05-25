# Glibc Makefile

NM= glibc
VRS= 2.3.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 82d0487419f1bdbf2dee439c344e89d6af47e558

FILE2= $(NM)-libidn-$(VRS).tar.bz2
#URL-$(FILE2)= $(HTTP)/$(NM)/$(FILE2)
URL-$(FILE2)= http://ftp.gnu.org/gnu/glibc/$(FILE2)
SHA-$(FILE2)= 95d3a98495d4bd7138149fd312db88da56e735db

PATCH1= $(NM)-$(VRS)-linux_types-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 0bdf2b15e20c176caf3c85e5b6a7bc957f636d6a

PATCH50= $(DIR)-supported_locales-2.patch

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(FILE2)
	$(sep_dir_build)
	cp $(SRC)/{$(FILE),$(FILE2)} $(LFSSRC)/

compile-stage1:
	../$(DIR)/configure --prefix=$(WD) --disable-profile \
	 --enable-add-ons --enable-kernel=2.6.0 --with-binutils=$(WD)/bin \
	 --without-gd --with-headers=$(WD)/include --without-selinux
	PARALLELMFLAGS="$(PM)" make
	# LFS says:
	# mkdir -v /tools/etc
	# We don't do this because Wget created this directory for us
	touch $(WD)/etc/ld.so.conf
	PARALLELMFLAGS="$(PM)" make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE) $(FILE2) $(PATCH1)
	$(sep_dir_build)
	cp $(SRC)/$(PATCH1) $(LFSSRC)/
	touch $@

compile-stage2:
	cd ../$(DIR) ; unpack ../$(FILE2)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
# The vi_VN.TCVN locale doesn't work, testcase: "LC_ALL=vi_VN.TCVN bash"
# Result: the prompt never comes back, CPU utilization is 100%
# (This may be a bash bug. Not reproducible on Debian Etch, though)
	sed -i '/vi_VN.TCVN/d' ../$(DIR)/localedata/SUPPORTED
	sed -i \
	's|libs -o|libs -L/usr/lib -Wl,-dynamic-linker=/lib/$(LINKER) -o|' \
	        ../$(DIR)/scripts/test-installation.pl
# LiveCD specific locale additions
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH50)
	../$(DIR)/configure --prefix=/usr --disable-profile \
	 --enable-add-ons --enable-kernel=2.6.0 --libexecdir=/usr/lib/glibc
	PARALLELMFLAGS="$(PM)" make
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
