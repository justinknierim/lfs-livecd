# Glibc Makefile

NM= glibc
ifneq ($(LFS-ARCH),x86_64)
VRS= 2.3.5
else
VRS= 20050926
endif
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
ifneq ($(LFS-ARCH),x86_64)
SHA-$(FILE)= 465cb1f4708dfa88606379cc1ebecb724c65f027
else
SHA-$(FILE)= 47753ac9e13fd955c77c3e2b2bbb278d009dcbc5
endif

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

PATCH40= $(DIR)-libgcc_eh-1.patch
URL-$(PATCH40)= $(HTTP)/$(NM)/$(PATCH40)
SHA-$(PATCH40)= 40656faedabfa072c02225ba7d21fc0e76bbacb3

PATCH41= $(DIR)-localedef_segfault-1.patch
URL-$(PATCH41)= $(HTTP)/$(NM)/$(PATCH41)
SHA-$(PATCH41)= ac908ef021764e90443e7cf7d72de87fe6168c38

# Targets

include $(ROOT)/scripts/functions

headers: $(FILE)
	$(sep_dir_build)

compile-headers:
	CC=gcc ../$(DIR)/configure --prefix=/tools \
	--host=$(LFS_TARGET) --build=$(LFS_HOST) --disable-sanity-checks \
	--enable-kernel=2.6.0 --with-headers=/tools/include \
	--with-binutils=/cross-tools/$(LFS_TARGET)/bin
	make install-headers
	install -v -d /tools/include/bits
	cp -v bits/stdio_lim.h /tools/include/bits
	touch /tools/include/gnu/stubs.h
	cp -v ../$(DIR)/nptl/sysdeps/pthread/pthread.h $(WD)/include
	cp -v ../$(DIR)/nptl/sysdeps/unix/sysv/linux/x86_64/bits/pthreadtypes.h \
	 $(WD)/include/bits

ifneq ($(LFS-ARCH),x86_64)
stage1: $(FILE) $(FILE1) $(PATCH1) $(PATCH2) $(PATCH3) $(PATCH4) $(PATCH5)
	$(sep_dir_build)
	cp $(SRC)/{$(FILE),$(FILE1),$(PATCH1),$(PATCH2),$(PATCH3),$(PATCH4),$(PATCH5)} $(LFSSRC)/

compile-stage1:
ifeq ($(LFS-ARCH),sparc)
	cd ../$(DIR) ; rm -rf nptl*
	cd ../$(DIR) ; unpack ../$(FILE1)
	cd ../$(DIR) ; sed -i 's@mv8@mcpu=v8@' sysdeps/unix/sysv/linux/sparc/sparc32/Makefile
else
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
endif
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
else

stage1: $(FILE) $(PATCH40)
	$(sep_dir_build)

compile-stage1:
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH40)
	echo "libc_cv_forced_unwind=yes" > config.cache
	echo "libc_cv_c_cleanup=yes" >> config.cache
	echo "slibdir=/tools/lib64" >> configparms
	BUILD_CC="gcc" CC="$(LFS_TARGET)-gcc" \
	AR="$(LFS_TARGET)-ar" RANLIB="$(LFS_TARGET)-ranlib" \
	../$(DIR)/configure --prefix=$(WD) --host=$(LFS_TARGET) \
	--build=$(LFS_HOST) --libdir=$(WD)/lib64 --disable-profile \
	--enable-add-ons --with-tls --enable-kernel=2.6.0 --with-__thread \
	--with-binutils=$(CROSS_WD)/bin --with-headers=$(WD)/include \
	--cache-file=config.cache
	PARALLELMFLAGS="$(PM)" make
	PARALLELMFLAGS="$(PM)" make install
endif

stage1-32: $(FILE) $(PATCH40)
	$(sep_dir_build)

compile-stage1-32:
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH40)
	echo "libc_cv_forced_unwind=yes" > config.cache
	echo "libc_cv_c_cleanup=yes" >> config.cache
	BUILD_CC="gcc" CC="$(LFS_TARGET)-gcc ${BUILD32}" \
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

stage2: $(FILE) $(FILE1) $(PATCH1) $(PATCH2) $(PATCH3) $(PATCH4) $(PATCH5) $(PATCH6)
	$(sep_dir_build)
	cp $(SRC)/$(PATCH6) $(LFSSRC)/
	touch $@

compile-stage2:
ifeq ($(LFS-ARCH),sparc)
	cd ../$(DIR) ; rm -rf nptl*
	cd ../$(DIR) ; sed -i 's@mv8@mcpu=v8@' sysdeps/unix/sysv/linux/sparc/sparc32/Makefile
endif
	cd ../$(DIR) ; unpack ../$(FILE1)
ifneq ($(LFS-ARCH),sparc)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
endif
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

.PHONY: compile-headers compile-stage1 compile-stage1-32 clean chroot compile-stage2
