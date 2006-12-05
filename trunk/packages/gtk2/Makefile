# Gtk+ Makefile

NM= gtk+
VRS= 2.8.20
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnome.org/pub/GNOME/sources/gtk+/2.8/$(FILE)
SHA-$(FILE)= 8ea2449ff139b8bc457f8b5bcdcad93b02cfba9e

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-gtk2 $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
