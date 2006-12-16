# Gcc Makefile

NM= gcc
VRS= 4.1.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= a398b95d38b6e35f4c4e02c34c0a3bff79811f8f

PATCH1= $(DIR)-fixes-1.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM)64 $(chbash-pre-bash)'

stage2: $(FILE)
	$(sep_dir_build)

compile-stage2:
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
	cd ../$(DIR) ; sed -i 's/install_to_$$(INSTALL_DEST) //' \
	 libiberty/Makefile.in
	cd ../$(DIR) ; sed -i 's/^XCFLAGS =$$/& -fomit-frame-pointer/' \
	 gcc/Makefile.in
	cd ../$(DIR) ; sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in
	cd ../$(DIR) ; sed -i 's/@have_mktemp_command@/yes/' gcc/gccbug.in
# --enable-static overrides the unsuitable default in config.site
	unset CFLAGS ; PATH=$$PATH:$(WD)/bin ../$(DIR)/configure --prefix=$(WD) --target=x86_64-unknown-linux-gnu \
	 --disable-shared --disable-threads --enable-languages=c --enable-static
	unset CFLAGS ; PATH=$$PATH:$(WD)/bin make all-gcc
	unset CFLAGS ;PATH=$$PATH:$(WD)/bin make install-gcc

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-pass1 clean chroot compile-pass2 compile-stage2
