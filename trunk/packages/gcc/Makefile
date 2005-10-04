# Gcc Makefile

NM= gcc
VRS= 4.0.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 2152cdf8cc49de6eef27c6c34f2880cc774e6fa1

PATCH1= $(DIR)-specs-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 04d4b7d68bfd6b362e9b75678584641a2dde7c2f

# Targets

include $(ROOT)/scripts/functions

pass1: $(FILE)
	$(sep_dir_build)
	cp $(SRC)/$(FILE) $(LFSSRC)/

compile-pass1:
	../$(DIR)/configure --prefix=$(WD) --libexecdir=$(WD)/lib \
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
	 sed 's@\(^NATIVE_SYSTEM_HEADER_DIR =\).*@\1 $(WD)/include@g' \
	 gcc/Makefile.in.orig > gcc/Makefile.in
	cd ../$(DIR) ; cp gcc/Makefile.in{,.tmp} && \
	 sed 's/^XCFLAGS =$$/& -fomit-frame-pointer/' gcc/Makefile.in.tmp \
         > gcc/Makefile.in
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
	../$(DIR)/configure --prefix=$(WD) --libexecdir=$(WD)/lib \
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
	cd ../$(DIR) ; sed -i 's/install_to_$(INSTALL_DEST) //' \
	 libiberty/Makefile.in
	cd ../$(DIR) ; sed -i 's/^XCFLAGS =$$/& -fomit-frame-pointer/' \
	 gcc/Makefile.in
	../$(DIR)/configure --prefix=/usr --libexecdir=/usr/lib \
	 --enable-shared --enable-threads=posix --enable-__cxa_atexit \
	 --enable-clocale=gnu --enable-languages=c,c++
	make $(PM)
	make install
	ln -sf ../usr/bin/cpp /lib
	ln -sf gcc /usr/bin/cc

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-pass1 clean chroot compile-pass2 compile-stage2
