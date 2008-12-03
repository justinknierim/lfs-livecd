# xkeyboard-config Makefile

NM= xkeyboard-config
VRS= 1.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 7ad0ff286233b3569ea38ab951f61efb2e4745b9

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man --localstatedir=/var \
	 --with-xkb-rules-symlink=xorg
	make
	make install
	install -dv -m755 /usr/share/doc/$(DIR)
	install -v -m644 docs/{README,HOWTO}* /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
