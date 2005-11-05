# libxslt Makefile

NM= libxslt
VRS= 1.1.15
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 73ecb3e0bbcb879b1b345e4691ddff2841439cdf

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
ifeq ($(LFS-ARCH),sparc64)
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr \
	 --libdir=/usr/lib64
else
	./configure --prefix=/usr
endif
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
