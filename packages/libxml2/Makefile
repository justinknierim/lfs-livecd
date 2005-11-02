# LibXML2 Makefile

NM= libxml2
VRS= 2.6.22
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 3f920523136d51b246569977df70e6893d925dd5

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
	  --libdir=/usr/lib64 --with-history
else
	./configure --prefix=/usr --with-history
endif
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
