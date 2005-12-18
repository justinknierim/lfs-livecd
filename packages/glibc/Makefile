# Glibc Makefile

NM= glibc
ifndef CROSS
VRS= 2.3.6
else
VRS= 20051107
endif
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
ifndef CROSS
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 82d0487419f1bdbf2dee439c344e89d6af47e558
else
URL-$(FILE)= ftp://sources.redhat.com/pub/glibc/snapshots/$(FILE)
SHA-$(FILE)= 9c7f190eb9d590a33384a24c3772bd3a13355575
endif

ifndef CROSS
FILE2= $(NM)-libidn-$(VRS).tar.bz2
#URL-$(FILE2)= $(HTTP)/$(NM)/$(FILE2)
URL-$(FILE2)= http://ftp.gnu.org/gnu/glibc/$(FILE2)
SHA-$(FILE2)= 95d3a98495d4bd7138149fd312db88da56e735db
endif

PATCH30= $(DIR)-sparc_tls-1.patch
URL-$(PATCH30)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH30)
SHA-$(PATCH30)= 5100d3728f58bc40f7f61de10c0b7a202b876aa5

PATCH40= $(DIR)-libgcc_eh-1.patch
URL-$(PATCH40)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH40)
SHA-$(PATCH40)= 19da4462ee85bc3c0e494d83f459394653a646e2

PATCH41= $(DIR)-localedef_segfault-1.patch
URL-$(PATCH41)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH41)
SHA-$(PATCH41)= ac908ef021764e90443e7cf7d72de87fe6168c38

STAGE1_DEPS= $(FILE) $(PATCH40)
STAGE2_DEPS= $(FILE) $(PATCH41)

PATCH50= $(DIR)-supported_locales-2.patch

# Targets

include $(ROOT)/scripts/functions

ifeq ($(LFS-ARCH),sparc64)
STAGE1_DEPS+= $(PATCH30) $(PATCH41)
STAGE2_DEPS+= $(PATCH30)
endif

headers: $(FILE)
	$(sep_dir_build)

compile-headers:
	cd ../$(DIR) ; cp configure{,.orig} ; sed -e 's/3.4/3.[0-9]/g' \
	 configure.orig > configure
	CC=gcc ../$(DIR)/configure --prefix=$(WD) \
	--host=$(LFS_TARGET) --build=$(LFS_HOST) --disable-sanity-checks \
	--enable-kernel=2.6.0 --with-headers=$(WD)/include \
	--with-binutils=$(CROSS_WD)/$(LFS_TARGET)/bin
	make install-headers
	install -v -d $(WD)/include/bits
	cp -v bits/stdio_lim.h $(WD)/include/bits
	touch $(WD)/include/gnu/stubs.h
	cp -v ../$(DIR)/nptl/sysdeps/pthread/pthread.h $(WD)/include
	cp -v ../$(DIR)/nptl/sysdeps/unix/sysv/linux/x86_64/bits/pthreadtypes.h \
	 $(WD)/include/bits

ifndef	CROSS
stage1: $(FILE) $(FILE2)
	$(sep_dir_build)
	cp $(SRC)/{$(FILE),$(FILE2)} $(LFSSRC)/

compile-stage1:
	cd ../$(DIR) ; unpack ../$(FILE2)
	../$(DIR)/configure --prefix=$(WD) --disable-profile \
	 --enable-add-ons --enable-kernel=2.6.0 --with-binutils=$(WD)/bin \
	 --without-gd --with-headers=$(WD)/include --without-selinux
	PARALLELMFLAGS="$(PM)" make
	touch $(WD)/etc/ld.so.conf
	PARALLELMFLAGS="$(PM)" make install
else

stage1: $(STAGE1_DEPS)
	$(sep_dir_build)

compile-stage1:
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH40)
ifeq ($(LFS-ARCH),sparc64)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH30) ; patch -Np1 -i ../$(PATCH41)
endif
	echo "libc_cv_forced_unwind=yes" > config.cache
	echo "libc_cv_c_cleanup=yes" >> config.cache
ifeq ($(LFS-ARCH),sparc64)
	echo "libc_cv_sparc64_tls=yes" >> config.cache
endif
	echo "slibdir=$(WD)/lib64" >> configparms
	BUILD_CC="gcc" CC="$(LFS_TARGET)-gcc $(64FLAGS)" \
	AR="$(LFS_TARGET)-ar" RANLIB="$(LFS_TARGET)-ranlib" \
	../$(DIR)/configure --prefix=$(WD) --host=$(LFS_TARGET) \
	--build=$(LFS_HOST) --libdir=$(WD)/lib64 --disable-profile \
	--enable-add-ons --with-tls --enable-kernel=2.6.0 --with-__thread \
	--with-binutils=$(CROSS_WD)/bin --with-headers=$(WD)/include \
	--cache-file=config.cache
	PARALLELMFLAGS="$(PM)" make
	PARALLELMFLAGS="$(PM)" make install
endif

stage1-32: $(STAGE1_DEPS)
	$(sep_dir_build)

compile-stage1-32:
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH40)
ifeq ($(LFS-ARCH),sparc64)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH30) ; patch -Np1 -i ../$(PATCH41)
endif
	echo "libc_cv_forced_unwind=yes" > config.cache
	echo "libc_cv_c_cleanup=yes" >> config.cache
	BUILD_CC="gcc" CC="$(LFS_TARGET)-gcc $(32FLAGS)" \
	AR="$(LFS_TARGET)-ar" RANLIB="$(LFS_TARGET)-ranlib" \
	../$(DIR)/configure --prefix=$(WD) --host=$(LFS_TARGET32) \
	--build=$(LFS_HOST) --disable-profile --enable-add-ons \
	--with-tls --enable-kernel=2.6.0 --with-__thread \
	--with-binutils=$(CROSS_WD)/bin --with-headers=$(WD)/include \
	--cache-file=config.cache
	PARALLELMFLAGS="$(PM)" make
	PARALLELMFLAGS="$(PM)" make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

ifndef CROSS
stage2: $(FILE)
	$(sep_dir_build)
	touch $@

compile-stage2:
	cd ../$(DIR) ; unpack ../$(FILE2)
# The vi_VN.TCVN locale doesn't work, testcase: "LC_ALL=vi_VN.TCVN bash"
# Result: the prompt never comes back, CPU utilization is 100%
# (this may be a bash bug)
	sed -i '/vi_VN.TCVN/d' ../$(DIR)/localedata/SUPPORTED
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

else
stage2: $(STAGE2_DEPS)
	$(sep_dir_build)
	for i in $(STAGE2_DEPS) ; do cp $(SRC)/$$i $(LFSSRC) ; done

compile-stage2:
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH41)
ifeq ($(LFS-ARCH),sparc64)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH30)
endif
# FIXME: is the following still true?
# The no_NO alias doesn't work, testcase: "LC_ALL=no_NO locale"
# Result: locale: Cannot set LC_CTYPE to default locale: No such file or directory
# The solution is to use the nb_NO locale instead of no_NO
	sed -i '/no_NO/d' ../$(DIR)/intl/locale.alias
# The vi_VN.TCVN locale doesn't work, testcase: "LC_ALL=vi_VN.TCVN bash"
# Result: the prompt never comes back, CPU utilization is 100%
# (this may be a bash bug)
	sed -i '/vi_VN.TCVN/d' ../$(DIR)/localedata/SUPPORTED
# LiveCD specific locale additions
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH50)
	echo "slibdir=/lib64" >> configparms
	CC="gcc $(64FLAGS)" CXX="g++ $(64FLAGS)" \
    	 ../$(DIR)/configure --prefix=/usr \
    	 --disable-profile --enable-add-ons --enable-kernel=2.6.0 \
    	 --libexecdir=/usr/lib64/glibc --libdir=/usr/lib64
	PARALLELMFLAGS="$(PM)" make
	touch /etc/ld.so.conf
	make install
	PARALLELMFLAGS="$(PM)" make localedata/install-locales
	cp $(ROOT)/etc/nsswitch.conf /etc
	cp --remove-destination /usr/share/zoneinfo/$(timezone) /etc/localtime
	cp $(ROOT)/etc/ld.so.conf-x86_64 /etc/ld.so.conf
endif

stage2-32: $(STAGE2_DEPS)
	$(sep_dir_build)

compile-stage2-32:
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH41)
ifeq ($(LFS-ARCH),sparc64)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH30)
endif
	CC="gcc $(32FLAGS)" CXX="g++ $(32FLAGS)" \
    	 ../$(DIR)/configure --prefix=/usr \
    	 --disable-profile --enable-add-ons --enable-kernel=2.6.0 \
    	 --libexecdir=/usr/lib/glibc --host=$(LFS_TARGET32)
	PARALLELMFLAGS="$(PM)" make
	touch /etc/ld.so.conf
	make install

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-headers compile-stage1 compile-stage1-32 clean chroot compile-stage2 \
	compile-stage2-32
