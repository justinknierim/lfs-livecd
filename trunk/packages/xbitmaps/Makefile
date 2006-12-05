# xbitmaps Makefile

NM= xbitmaps
VRS= 1.0.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://xorg.freedesktop.org/releases/individual/data/$(FILE)
SHA-$(FILE)= 6c0fd6f7c9bba682aa0216b4d91a6e9a6b7f01cf

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
