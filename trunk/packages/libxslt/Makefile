# libxslt Makefile

NM= libxslt
VRS= 1.1.15
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://xmlsoft.org/sources/$(FILE)
SHA-$(FILE)= f0c8ef4809104bf59ebf5b23a637e7dff61a2aa4

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
