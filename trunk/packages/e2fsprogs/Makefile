# E2fsprogs Makefile

NM= e2fsprogs
VRS= 1.38
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 6252152e90c52a8cf158559cd16c0d0ec236c980

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	mkdir build
	cd build ; ../configure --prefix=/usr --with-root-prefix="" \
	 --enable-elf-shlibs --disable-evms
	cd build ; make
	cd build ; make install
	cd build ; make install-libs

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
