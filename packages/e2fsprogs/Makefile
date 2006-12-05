# E2fsprogs Makefile

NM= e2fsprogs
VRS= 1.39
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= c2dad0c9bd76701eafe3804e2a7d072aa198f046

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	sed -i -e 's@/bin/rm@/tools&@' lib/blkid/test_probe.in
	mkdir -v build
	cd build ; ../configure --prefix=/usr --with-root-prefix="" \
	 --enable-elf-shlibs --disable-evms
	cd build ; make
	cd build ; make install
	cd build ; make install-libs

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
