# Gcc Makefile

NM= gcc
VRS= 4.0.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 5a94943d9ab823cf8d080cc7f9e8a4a91797afea

PATCH1= $(DIR)-specs-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 04d4b7d68bfd6b362e9b75678584641a2dde7c2f

# Targets

include $(ROOT)/scripts/functions

export LFS_USE_TARGET := yes

pass1: $(FILE)
	$(sep_dir_build)
	cp $(SRC)/$(FILE) $(LFSSRC)/

compile-pass1:
# --enable-static overrides the unsuitable default in config.site
	../$(DIR)/configure --prefix=$(WD) \
	 --with-local-prefix=$(WD) --disable-nls --enable-shared \
	 --enable-languages=c --enable-static
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
# --enable-static overrides the unsuitable default in config.site
	../$(DIR)/configure --prefix=$(WD) \
	 --with-local-prefix=$(WD) --enable-clocale=gnu --enable-shared \
	 --enable-threads=posix --enable-__cxa_atexit --enable-languages=c,c++ \
	 --disable-libstdcxx-pch --enable-static
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
	cd ../$(DIR) ; sed -i 's/^XCFLAGS =$$/& -fomit-frame-pointer/' \
	 gcc/Makefile.in
	cd ../$(DIR) ; sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in
	cd ../$(DIR) ; sed -i 's/@have_mktemp_command@/yes/' gcc/gccbug.in
# --enable-static overrides the unsuitable default in config.site
	../$(DIR)/configure --prefix=/usr --libexecdir=/usr/lib \
	 --enable-shared --enable-threads=posix --enable-__cxa_atexit \
	 --enable-clocale=gnu --enable-languages=c,c++ --enable-static
	make $(PM)
	-make -k check
	make install
	ln -sf ../usr/bin/cpp /lib
	ln -sf gcc /usr/bin/cc

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-pass1 clean chroot compile-pass2 compile-stage2
