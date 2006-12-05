# libpng Makefile

NM= libpng
VRS= 1.2.12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://easynews.dl.sourceforge.net/libpng/$(FILE)
SHA-$(FILE)= 44bd6821607ba09ac500279363871ad5974a01b5

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
	# Stray symlink because we disable static libraries
	rm -f /usr/lib/libpng.a
	install -v -m755 -d /usr/share/doc/$(DIR)
	install -v -m644 README libpng.txt /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
