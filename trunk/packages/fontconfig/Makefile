# Fontconfig Makefile

NM= fontconfig
VRS= 2.4.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= cd5e30625680a0435563b586275156eaf8d0d34a

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc \
	 --localstatedir=/var \
	 --disable-docs --without-add-fonts \
	 --with-docdir=/usr/share/doc/$(DIR)
	make
	make install
	install -v -m644 doc/*.3 /usr/share/man/man3
	install -v -m644 doc/*.5 /usr/share/man/man5
	install -v -m755 -d /usr/share/doc/$(DIR)/fontconfig-devel
	install -v -m644 doc/*.{html,pdf,txt} \
	 /usr/share/doc/$(DIR)
	install -v -m644 doc/fontconfig-devel/* \
	 /usr/share/doc/$(DIR)/fontconfig-devel

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
