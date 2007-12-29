# Pkgconfig Makefile

NM= pkg-config
VRS= 0.22
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://pkgconfig.freedesktop.org/releases/$(FILE)
SHA-$(FILE)= 3ec40bda9864d7aa3c912c6ae87a750fd8b6e420

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
