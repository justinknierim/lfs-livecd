# Glibc Makefile

NM= glibc
VRS= 2.3.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 465cb1f4708dfa88606379cc1ebecb724c65f027

FILE1= $(NM)-linuxthreads-2.3.5.tar.bz2
URL-$(FILE1)= $(HTTP)/$(NM)/$(FILE1)
SHA-$(FILE1)= bfc44a76a708f905fe9c414162d5efcd3d47355f

PATCH1= $(DIR)-fix_test-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 40656faedabfa072c02225ba7d21fc0e76bbacb3

PATCH2= $(DIR)-gcc4_fix_symbols-1.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 22d71f8368cb5de8f906b2aa50f7f27ff90a832a

PATCH3= $(DIR)-gcc4_fix_string-1.patch
URL-$(PATCH3)= $(HTTP)/$(NM)/$(PATCH3)
SHA-$(PATCH3)= cd0888185c423fe50da823a8d3fa1abb55913bfa

PATCH4= $(DIR)-gcc4_fix_elf-1.patch
URL-$(PATCH4)= $(HTTP)/$(NM)/$(PATCH4)
SHA-$(PATCH4)= 5c648e3a7f7c6a80be60e4b7b99d0be915898803

PATCH5= $(DIR)-gcc4_fix_iconvdata-1.patch
URL-$(PATCH5)= $(HTTP)/$(NM)/$(PATCH5)
SHA-$(PATCH5)= b03258c1869d7ddb9f41e920d1b4a19a8d860a7d

PATCH6= $(DIR)-gcc4_fix_math_tests-1.patch
URL-$(PATCH6)= $(HTTP)/$(NM)/$(PATCH6)
SHA-$(PATCH6)= 32f42c062a3a0bfa651cedf015988537ad88dcaa

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(FILE1) $(PATCH1) $(PATCH2) $(PATCH3) $(PATCH4) $(PATCH5)
	$(sep_dir_build)
	cp $(SRC)/{$(FILE),$(FILE1),$(PATCH1),$(PATCH2),$(PATCH3),$(PATCH4),$(PATCH5)} $(LFSSRC)/

compile-stage1:
ifeq ($(LFS-ARCH),sparc)
	cd ../$(DIR) ; rm -rf nptl*
endif
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH2)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH3)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH4)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH5)
	../$(DIR)/configure --prefix=$(WD) --disable-profile \
	 --enable-add-ons --enable-kernel=2.6.0 --with-binutils=$(WD)/bin \
	 --without-gd --with-headers=$(WD)/include --without-selinux
	PARALLELMFLAGS="$(PM)" make
	touch $(WD)/etc/ld.so.conf
	PARALLELMFLAGS="$(PM)" make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE) $(FILE1) $(PATCH1) $(PATCH2) $(PATCH3) $(PATCH4) $(PATCH5) $(PATCH6)
	$(sep_dir_build)
	cp $(SRC)/$(PATCH6) $(LFSSRC)/
	touch $@

compile-stage2:
ifeq ($(LFS-ARCH),sparc)
	cd ../$(DIR) ; rm -rf nptl*
endif
	cd ../$(DIR) ; unpack ../$(FILE1)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH2)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH3)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH4)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH5)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH6)
	../$(DIR)/configure --prefix=/usr --disable-profile \
	 --enable-add-ons --enable-kernel=2.6.0 --libexecdir=/usr/lib/glibc
	PARALLELMFLAGS="$(PM)" make
	touch /etc/ld.so.conf
	PARALLELMFLAGS="$(PM)" make install
	PARALLELMFLAGS="$(PM)" make localedata/install-locales
	make -C ../$(DIR)/linuxthreads/man
	make -C ../$(DIR)/linuxthreads/man install
	cp $(ROOT)/etc/nsswitch.conf /etc
	cp --remove-destination /usr/share/zoneinfo/$(timezone) /etc/localtime
	cp $(ROOT)/etc/ld.so.conf /etc

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-stage1 clean chroot compile-stage2
