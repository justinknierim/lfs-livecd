# Gtk+ Makefile

NM= gtk+
VRS= 2.14.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= ed480432b57a41e04896642465e58ceeb179ca22

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-gtk2 $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's/-ljasper -ljpeg/& -lm/' configure
	./configure --prefix=/usr --sysconfdir=/etc
	make
	make install
	install -v -m755 -d /usr/share/doc/$(DIR)/{faq,tutorial}
	cp -v -R docs/faq/html/* /usr/share/doc/$(DIR)/faq
	cp -v -R docs/tutorial/html/* /usr/share/doc/$(DIR)/tutorial
	install -v -m644 docs/*.txt /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
