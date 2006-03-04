# Gcc Makefile

NM= gcc
VRS= 4.0.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= f1b714c6398393d8f7f4ad5be933b462a95b075d

PATCH1= $(DIR)-specs-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 04d4b7d68bfd6b362e9b75678584641a2dde7c2f

PATCH40= $(DIR)-posix-1.patch
URL-$(PATCH40)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH40)
SHA-$(PATCH40)= b3629af7348869b7d0a18cbfe19aa362aeb48fd1

PATCH41= $(DIR)-cross_search_paths-1.patch
URL-$(PATCH41)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH41)
SHA-$(PATCH41)= ca4b874774e20da34671acf391e86a3d7c9a9bb3

include $(CROSSVARS)

# Targets

include $(ROOT)/scripts/functions

cross-static: $(FILE) $(PATCH1) $(PATCH40) $(PATCH41)
	$(sep_dir_build)
	cp $(SRC)/{$(FILE),$(PATCH1),$(PATCH40),$(PATCH41)} $(LFSSRC)

compile-cross-static:
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1) ; \
	 patch -Np1 -i ../$(PATCH40) ; patch -Np1 -i ../$(PATCH41)
	cd ../$(DIR) ; for HEADER in $(STARTFILE_PREFIX_SPEC_HEADERS) ; do \
	 echo " " >> $$HEADER ; \
	 echo "#undef STARTFILE_PREFIX_SPEC" >> $$HEADER ; \
	 echo "#define STARTFILE_PREFIX_SPEC \"$(WD)/lib/\"" >> $$HEADER ; done
	cd ../$(DIR) ; cp gcc/Makefile.in{,.orig} ; sed "s@\(^CROSS_SYSTEM_HEADER_DIR =\).*@\1 $(WD)/include@g" \
	 gcc/Makefile.in.orig > gcc/Makefile.in
	../$(DIR)/configure --prefix=$(CROSS_WD) --host=$(LFS_HOST) \
	 --target=$(LFS_TARGET) --with-local-prefix=$(WD) --disable-nls \
	 --disable-shared --disable-threads --enable-languages=c 
	make $(CFLAGS_FOR_TARGET) $(PM) all-gcc
	make install-gcc

cross: $(FILE) $(PATCH1) $(PATCH40) $(PATCH41)
	$(sep_dir_build)

compile-cross:
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1) ; \
	 patch -Np1 -i ../$(PATCH40) ; patch -Np1 -i ../$(PATCH41)
	cd ../$(DIR) ; for HEADER in $(STARTFILE_PREFIX_SPEC_HEADERS) ; do \
	 echo " " >> $$HEADER ; \
	 echo "#undef STARTFILE_PREFIX_SPEC" >> $$HEADER ; \
	 echo "#define STARTFILE_PREFIX_SPEC \"$(WD)/lib/\"" >> $$HEADER ; done
	cd ../$(DIR) ; cp gcc/Makefile.in{,.orig} ; \
	 sed "s@\(^CROSS_SYSTEM_HEADER_DIR =\).*@\1 $(WD)/include@g" \
	 gcc/Makefile.in.orig > gcc/Makefile.in
	cd ../$(DIR) ; cp configure{,.orig} ; \
	 sed '/FLAGS_FOR_TARGET.*\/lib\//s@-B[^ ]*/lib/@@g' configure.orig > configure
	../$(DIR)/configure --prefix=$(CROSS_WD) --target=$(LFS_TARGET) \
	 --host=$(LFS_HOST) --with-local-prefix=$(WD) --disable-nls \
	 --enable-shared --enable-languages=c,c++ --enable-__cxa_atexit \
	 --enable-c99 --enable-long-long --enable-threads=posix
	make $(PM) AS_FOR_TARGET="$(CROSS_WD)/bin/$(LFS_TARGET)-as" \
	 LD_FOR_TARGET="$(CROSS_WD)/bin/$(LFS_TARGET)-ld"
	make install

stage1: $(FILE) $(PATCH1) $(PATCH40) $(PATCH41)
	$(sep_dir_build)

compile-stage1:
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1) ; \
	 patch -Np1 -i ../$(PATCH40) ; patch -Np1 -i ../$(PATCH41)
	cd ../$(DIR) ; cp gcc/cppdefault.c{,.bak} ; \
	 sed '/#define STANDARD_INCLUDE_DIR/s@"/usr/include"@0@g' \
	 gcc/cppdefault.c.bak > gcc/cppdefault.c
	cd ../$(DIR) ; cp gcc/Makefile.in{,.bak} ; \
	 sed 's@\(^NATIVE_SYSTEM_HEADER_DIR =\).*@\1 /tools/include@g' \
	 gcc/Makefile.in.bak > gcc/Makefile.in
	cd ../$(DIR) ; cp gcc/mklibgcc.in{,.bak} ; \
	 sed "s@\./xgcc@/$(CROSS_WD)/bin/$${CC}@g" \
	 gcc/mklibgcc.in.bak > gcc/mklibgcc.in
	cd ../$(DIR) ; cp gcc/Makefile.in{,.bk2} ; \
	 sed "/MULTILIBS/s@\$$(GCC_FOR_TARGET)@$(CROSS_WD)/bin/$${CC}@g" \
	 gcc/Makefile.in.bk2 > gcc/Makefile.in
	CC="$${CC} $(64FLAGS)" CXX="$${CXX} $(64FLAGS)" ../$(DIR)/configure \
	 --prefix=$(WD) --libdir=$(WD)/$(LIB_MAYBE64) --build=$(LFS_HOST) \
	 --host=$(LFS_TARGET) --target=$(LFS_TARGET) \
	 --with-local-prefix=$(WD) --enable-long-long --enable-c99 \
	 --enable-shared --enable-threads=posix --enable-__cxa_atexit \
	 --disable-nls --enable-languages=c,c++ --disable-libstdcxx-pch
	make AS_FOR_TARGET="$(CROSS_WD)/bin/$(LFS_TARGET)-as" \
	 LD_FOR_TARGET="$(CROSS_WD)/bin/$(LFS_TARGET)-ld" \
	 $(EXTRA_FLAGS_FOR_TOOLS) $(PM)
	make install
	ln -s gcc $(WD)/bin/cc

pass1: $(FILE)
	$(sep_dir_build)
	cp $(SRC)/$(FILE) $(LFSSRC)/

compile-pass1:
	../$(DIR)/configure --prefix=$(WD) \
	 --with-local-prefix=$(WD) --disable-nls --enable-shared \
	 --enable-languages=c
	make $(PM) bootstrap
	make install
	ln -s gcc $(WD)/bin/cc

pass2: $(FILE) $(PATCH1)
	$(sep_dir_build)
	cp $(SRC)/$(PATCH1) $(LFSSRC)/

compile-pass2:
	cd ../$(DIR) ; cp gcc/Makefile.in{,.orig} && \
	 sed 's@\./fixinc\.sh@-c true@' gcc/Makefile.in.orig > gcc/Makefile.in
	cd ../$(DIR) ; cp gcc/Makefile.in{,.tmp} && \
	 sed 's/^XCFLAGS =$$/& -fomit-frame-pointer/' gcc/Makefile.in.tmp \
	 > gcc/Makefile.in
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
	../$(DIR)/configure --prefix=$(WD) \
	 --with-local-prefix=$(WD) --enable-clocale=gnu --enable-shared \
	 --enable-threads=posix --enable-__cxa_atexit --enable-languages=c,c++ \
	 --disable-libstdcxx-pch
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE)
	$(sep_dir_build)

compile-stage2:
	cd ../$(DIR) ; sed -i 's/install_to_$$(INSTALL_DEST) //' \
	 libiberty/Makefile.in
ifndef CROSS
	cd ../$(DIR) ; sed -i 's/^XCFLAGS =$$/& -fomit-frame-pointer/' \
	 gcc/Makefile.in
	cd ../$(DIR) ; sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in
	../$(DIR)/configure --prefix=/usr --libexecdir=/usr/lib \
	 --enable-shared --enable-threads=posix --enable-__cxa_atexit \
	 --enable-clocale=gnu --enable-languages=c,c++
else
	CC="gcc $(64FLAGS)" CXX="g++ $(64FLAGS)" \
	../$(DIR)/configure --prefix=/usr --libdir=/usr/$(LIB_MAYBE64) \
	 --libexecdir=/usr/$(LIB_MAYBE64) --enable-shared --enable-threads=posix \
	 --enable-__cxa_atexit --enable-c99 --enable-long-long \
	 --enable-clocale=gnu --enable-languages=c,c++ --disable-libstdcxx-pch
endif
	cd ../$(DIR) ; sed -i 's/@@have_mktemp_command@@/yes/' gcc/gccbug.in
	make $(PM)
	make install
	ln -sf ../usr/bin/cpp /lib
	ln -sf gcc /usr/bin/cc

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-cross-static compile-cross compile-stage1 compile-pass1 clean chroot \
 	compile-pass2 compile-stage2
