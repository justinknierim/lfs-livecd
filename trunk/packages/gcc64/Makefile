# Gcc Makefile

NM= gcc
VRS= 4.0.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 5a94943d9ab823cf8d080cc7f9e8a4a91797afea

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM)64 $(chbash-pre-bash)'

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
	PATH=$$PATH:$(WD)/bin ../$(DIR)/configure --prefix=$(WD) --target=x86_64-unknown-linux-gnu \
	 --disable-shared --disable-threads --enable-languages=c --enable-static
	PATH=$$PATH:$(WD)/bin make all-gcc
	PATH=$$PATH:$(WD)/bin make install-gcc

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: compile-pass1 clean chroot compile-pass2 compile-stage2
