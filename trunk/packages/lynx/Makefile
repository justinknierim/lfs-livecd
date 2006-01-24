# Lynx Makefile

NM= lynx
VRS= 2.8.5
DIR= $(NM)2-8-5

FILE= $(NM)$(VRS).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= c70866f67c1365b55e0c9c0c569190f5919d28d4

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --libdir=/etc --with-zlib --with-bzlib \
	    --enable-nls --with-ssl --enable-charset-choice \
	    --enable-locale-charset --with-screen=ncursesw
	make $(PM)
	make install
	sed -i 's/#LOCALE_CHARSET:FALSE/LOCALE_CHARSET:TRUE/' /etc/lynx.cfg
	make docdir=/usr/share/doc/$(NM)-$(VRS)/doc \
	 helpdir=/usr/share/doc/$(NM)-$(VRS)/help install-full
	chgrp -R root /usr/share/doc/$(NM)-$(VRS)/doc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
