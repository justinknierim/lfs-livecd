# XFS Progs Makefile

NM= xfsprogs
VRS= 2.6.36
DIR= $(NM)-$(VRS)

FILE= $(DIR).src.tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= e05d9390bfdb53e34be0a30ae495afc02ca08bad

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(DIR)-fix_compile-1.patch
ifeq ($(LFS-ARCH),sparc64)
	OPTIMIZER="-Os" CC="gcc -m64 $(64FLAGS)" make
else
	OPTIMIZER="-Os" make
endif
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
