# libjpeg Makefile

NM= libjpeg
VRS= 6b
DIR= jpeg-$(VRS)

FILE= jpegsrc.v$(VRS).tar.gz
URL-$(FILE)= $(HTTPBLFS)/jpeg/$(FILE)
SHA-$(FILE)= 7079f0d6c42fad0cfba382cf6ad322add1ace8f9

#PATCH= $(DIR)-config_update-1.patch
#URL-$(PATCH)= http://svn.cross-lfs.org/svn/repos/patches/jpeg/$(PATCH)
#SHA-$(PATCH)= 5d99bf64e42500b7c357684ed153ad5ecbaa3c2c

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	#patch -Np1 -i ../$(PATCH)
	./configure --prefix=/usr --enable-static --enable-shared
	make
	make install
	/sbin/ldconfig

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
