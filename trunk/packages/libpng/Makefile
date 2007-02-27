# libpng Makefile

NM= libpng
VRS= 1.2.16
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://easynews.dl.sourceforge.net/libpng/$(FILE)
SHA-$(FILE)= 0b37d42d2ae33c22093d46a28e6b8fa21eb4c1da

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
	install -v -m644 README libpng-$(VRS).txt /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
