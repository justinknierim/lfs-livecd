# ImLib Makefile

NM= imlib
VRS= 1.9.15
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnome.org/pub/GNOME/sources/$(NM)/1.9/$(FILE)
SHA-$(FILE)= c9a732a354fbb3c7e1a426e5d19fc92d73f8f720

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc/imlib
	make
	make install
	install -d -m755 /usr/share/doc/$(DIR)
	install -m644 doc/{*.gif,index.html} /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
