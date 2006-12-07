# Binutils Makefile

NM= binutils
VRS= 2.17
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= a557686eef68362ea31a3aa41ce274e3eeae1ef0

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM)64 $(chbash-pre-bash)'

stage2: $(FILE)
	$(sep_dir_build)

compile-stage2:
	../$(DIR)/configure --prefix=$(WD) --enable-shared --enable-64-bit-bfd \
	    --target=x86_64-unknown-linux-gnu
	make configure-host
	make
	make install

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: clean chroot compile-stage2
