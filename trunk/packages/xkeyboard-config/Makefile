# xkeyboard-config Makefile

NM= xkeyboard-config
VRS= 0.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://xlibs.freedesktop.org/xkbdesc/$(FILE)
SHA-$(FILE)= 05139163da656001fd837c6678254665c0d8ca00

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	rm -rf /usr/share/X11/xkb/compiled
	mkdir -p /var/lib/xkb
	./configure --prefix=/usr --sysconfdir=/etc \
	    --with-xkb-base=/usr/share/X11/xkb --with-xkb-rules-symlink=xorg \
	    --enable-compat-rules
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
