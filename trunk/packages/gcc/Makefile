# Gcc Makefile

NM= gcc
VRS= 4.3.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 787b566ad4f386a9896e2d5703e6ff5e7ccaca58

FILE1= mpfr-2.3.2.tar.bz2
URL-$(FILE1)= $(HTTP)/mpfr/$(FILE1)
SHA-$(FILE1)= 37dbd478e1c136f37cf4c68eb1522e86e2307288

FILE2= gmp-4.2.4.tar.bz2
URL-$(FILE2)= $(HTTP)/gmp/$(FILE2)
SHA-$(FILE2)= bb721f94fbeeb8c609104540b408da6707c370ec

# Targets

include $(ROOT)/scripts/functions

export LFS_USE_TARGET := yes

pass1: $(FILE) $(FILE1) $(FILE2)
	$(sep_dir_build)

compile-pass1:
	cd ../$(DIR) ; unpack ../$(FILE1)
	cd ../$(DIR) ; mv mpfr-2.3.2 mpfr
	cd ../$(DIR) ; unpack ../$(FILE2)
	cd ../$(DIR) ; mv gmp-4.2.4 gmp	
	CC="gcc -B/usr/bin/" ../$(DIR)/configure --prefix=$(WD) \
	 --with-local-prefix=$(WD) --disable-nls --disable-shared \
	 --enable-languages=c --disable-libssp --disable-multilib
	make
	make install
	ln -vs libgcc.a `gcc -print-libgcc-file-name | sed 's/libgcc/&_eh/'`
	ln -vs gcc $(WD)/bin/cc

pass2: $(FILE) $(FILE1) $(FILE2)
	$(sep_dir_build)

compile-pass2:
	cd ../$(DIR) ; cp -v gcc/Makefile.in{,.orig} && \
	 sed 's@\./fixinc\.sh@-c true@' gcc/Makefile.in.orig > gcc/Makefile.in
	cd ../$(DIR) ; cp -v gcc/Makefile.in{,.tmp} && \
	 sed 's/^XCFLAGS =$$/& -fomit-frame-pointer/' gcc/Makefile.in.tmp \
	 > gcc/Makefile.in
	cd ../$(DIR) ; for file in $$(find gcc/config -name linux64.h -o -name linux.h) ; \
	do \
	cp -uv $$file{,.orig} && \
	sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' -e 's@/usr@/tools@g' $$file.orig > $$file && \
	echo " " >> $$file && \
	echo "#undef STANDARD_INCLUDE_DIR" >> $$file && \
	echo "#define STANDARD_INCLUDE_DIR 0" >> $$file && \
	touch $$file.orig ; \
	done
ifdef 64bit
	cd ../$(DIR) ; cp -v gcc/config/i386/t-linux64{,.tmp} && \
	 sed '/MULTILIB_OSDIRNAMES/d' gcc/config/i386/t-linux64.tmp \
	 > gcc/config/i386/t-linux64
endif
	cd ../$(DIR) ; unpack ../$(FILE1)
	cd ../$(DIR) ; mv mpfr-2.3.2 mpfr
	cd ../$(DIR) ; unpack ../$(FILE2)
	cd ../$(DIR) ; mv gmp-4.2.4 gmp
	../$(DIR)/configure --prefix=$(WD) \
	 --with-local-prefix=$(WD) --enable-clocale=gnu --enable-shared \
	 --enable-threads=posix --enable-__cxa_atexit --enable-languages=c,c++ \
	 --disable-libstdcxx-pch --disable-bootstrap --disable-multilib
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE)
	$(sep_dir_build)

compile-stage2:
	cd ../$(DIR) ; sed -i 's/install_to_$$(INSTALL_DEST) //' \
	 libiberty/Makefile.in
	cd ../$(DIR) ; sed -i 's/^XCFLAGS =$$/& -fomit-frame-pointer/' \
	 gcc/Makefile.in
	cd ../$(DIR) ; sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in
	../$(DIR)/configure --prefix=/usr --libexecdir=/usr/lib \
	 --enable-shared --enable-threads=posix --enable-__cxa_atexit \
	 --enable-clocale=gnu --enable-languages=c,c++ --disable-bootstrap \
	 --disable-multilib
	make
	-make -k check
	make install
	ln -svf ../usr/bin/cpp /lib
	ln -svf gcc /usr/bin/cc

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-pass1 clean chroot compile-pass2 compile-stage2
