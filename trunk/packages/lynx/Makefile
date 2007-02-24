# Lynx Makefile

NM= lynx
VRS= 2.8.6
DIR= $(NM)2-8-6

FILE= $(NM)$(VRS).tar.bz2
URL-$(FILE)= http://lynx.isc.org/$(NM)$(VRS)/$(NM)$(VRS).tar.bz2
SHA-$(FILE)= b4e37025e99aabaddb219b2f27b1b0ac5db89708

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --with-zlib --with-bzlib \
	    --with-ssl --enable-charset-choice --enable-nls \
	    --enable-locale-charset --with-screen=ncursesw
	make
	make docdir=/usr/share/doc/$(NM)-$(VRS)/doc \
	 helpdir=/usr/share/doc/$(NM)-$(VRS)/help install-full
	chgrp -R root /usr/share/doc/$(NM)-$(VRS)/doc
	sed -i 's/#LOCALE_CHARSET:FALSE/LOCALE_CHARSET:TRUE/' /etc/lynx.cfg

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
