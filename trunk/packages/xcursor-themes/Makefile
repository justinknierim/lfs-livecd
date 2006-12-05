# xcursor-themes Makefile

NM= xcursor-themes
VRS= 1.0.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://xorg.freedesktop.org/releases/individual/data/$(FILE)
SHA-$(FILE)= cb6d31fe2ef5563a642bfe79f006ee7f6b17576f

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
