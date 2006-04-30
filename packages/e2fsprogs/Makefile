# E2fsprogs Makefile

NM= e2fsprogs
VRS= 1.38
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= aa8915fe43bc7cf5fba633df7041009ce9981551

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	mkdir build
ifndef CROSS
	cd build ; ../configure --prefix=/usr --with-root-prefix="" \
	 --enable-elf-shlibs --disable-evms
	cd build ; make
else
	sed -i '/libdir=.*\/lib/s@/lib@/lib64@g' configure
	cd build ; CC="gcc $(64FLAGS)" ../configure --prefix=/usr \
	 --with-root-prefix="" --enable-elf-shlibs --disable-evms
	cd build ; make CC="gcc $(64FLAGS)"
endif
	cd build ; make install
	cd build ; make install-libs

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
