# E2fsprogs Makefile

NM= e2fsprogs
VRS= 1.40.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/e2fsprogs/$(FILE)
SHA-$(FILE)= 65519d66bd15550d0bcd32ec72481ff0dbe737e2

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i -e 's@/bin/rm@/tools&@' lib/blkid/test_probe.in
	mkdir -v build
	cd build ; ../configure --prefix=/usr --with-root-prefix="" \
	 --enable-elf-shlibs
	cd build ; make
	cd build ; make install
	cd build ; make install-libs

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
