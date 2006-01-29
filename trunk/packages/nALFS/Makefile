# nALFS Makefile

NM= nALFS
VRS= 1.2.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= de75056fcfb9d73af6c0fe7fbfc76f3992a320ba

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build) 

compile-stage2:
	./configure --prefix=/usr --with-libxml2 \
	 --with-curl --with-ssl
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
