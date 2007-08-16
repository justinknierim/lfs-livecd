# Gcc Makefile

NM= gcc
VRS= 4.1.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 7981b8d1b58b10ddfd7d5142eab16352d9206f3b

PATCH1= $(DIR)-specs-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 1bdfbb49437642d3e450f0e3ba25a3e30e25e857

# Targets

include $(ROOT)/scripts/functions

export LFS_USE_TARGET := yes

pass1: $(FILE)
	$(sep_dir_build)

compile-pass1:
# --enable-static overrides the unsuitable default in config.site
	unset CFLAGS ; CC="gcc -B/usr/bin/" ../$(DIR)/configure --prefix=$(WD) \
	 --with-local-prefix=$(WD) --disable-nls --enable-shared \
	 --enable-languages=c --enable-static --disable-multilib
	unset CFLAGS ; make bootstrap
	unset CFLAGS ; make install
	ln -vs gcc $(WD)/bin/cc

pass2: $(FILE) $(PATCH1)
	$(sep_dir_build)

compile-pass2:
	cd ../$(DIR) ; cp -v gcc/Makefile.in{,.orig} && \
	 sed 's@\./fixinc\.sh@-c true@' gcc/Makefile.in.orig > gcc/Makefile.in
	cd ../$(DIR) ; cp -v gcc/Makefile.in{,.tmp} && \
	 sed 's/^XCFLAGS =$$/& -fomit-frame-pointer/' gcc/Makefile.in.tmp \
	 > gcc/Makefile.in
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
ifdef 64bit
	cd ../$(DIR) ; cp -v gcc/config/i386/t-linux64{,.tmp} && \
	 sed '/MULTILIB_OSDIRNAMES/d' gcc/config/i386/t-linux64.tmp \
	 > gcc/config/i386/t-linux64
endif
# --enable-static overrides the unsuitable default in config.site
	../$(DIR)/configure --prefix=$(WD) \
	 --with-local-prefix=$(WD) --enable-clocale=gnu --enable-shared \
	 --enable-threads=posix --enable-__cxa_atexit --enable-languages=c,c++ \
	 --disable-libstdcxx-pch --enable-static --disable-multilib
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE) $(PATCH1)
	$(sep_dir_build)

compile-stage2:
	cd ../$(DIR) ; sed -i 's/install_to_$$(INSTALL_DEST) //' \
	 libiberty/Makefile.in
	cd ../$(DIR) ; sed -i 's/^XCFLAGS =$$/& -fomit-frame-pointer/' \
	 gcc/Makefile.in
	cd ../$(DIR) ; sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in
	cd ../$(DIR) ; sed -i 's/@have_mktemp_command@/yes/' gcc/gccbug.in
# --enable-static overrides the unsuitable default in config.site
	../$(DIR)/configure --prefix=/usr --libexecdir=/usr/lib \
	 --enable-shared --enable-threads=posix --enable-__cxa_atexit \
	 --enable-clocale=gnu --enable-languages=c,c++ --enable-static \
	 --disable-multilib
	make
	#-make -k check
	make install
	ln -svf ../usr/bin/cpp /lib
	ln -svf gcc /usr/bin/cc

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-pass1 clean chroot compile-pass2 compile-stage2
