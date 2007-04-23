# Gtk+ Makefile

NM= gtk+
VRS= 2.10.11
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnome.org/pub/GNOME/sources/gtk+/2.10/$(FILE)
SHA-$(FILE)= 3c68f3fa13ab72f6b190cbe958813d29955042e2

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-gtk2 $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
