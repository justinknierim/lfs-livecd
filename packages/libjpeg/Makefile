# libjpeg Makefile

NM= libjpeg
VRS= 6b
DIR= jpeg-$(VRS)

FILE= jpegsrc.v$(VRS).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/jpeg/$(FILE)
SHA-$(FILE)= 0b4ef1e7dcee85e631a958b1ea493b6b0f2f2250

PATCH= $(DIR)-config_update-1.patch
URL-$(PATCH)= http://svn.cross-lfs.org/svn/repos/patches/jpeg/$(PATCH)
SHA-$(PATCH)= 5d99bf64e42500b7c357684ed153ad5ecbaa3c2c

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH)
	./configure --prefix=/usr --enable-static --enable-shared
	make
	make mandir=/usr/share/man/man1 install
	/sbin/ldconfig

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
