# Lynx Makefile

NM= lynx
VRS= 2.8.6rel.5
DIR= $(NM)2-8-6

FILE= $(NM)$(VRS).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 019246b83fc7b6cb32bac0023f2ae6c5d330d18c

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc/lynx \
	 --datadir=/usr/share/doc/$(NM)-$(VRS) --with-zlib --with-bzlib \
	 --with-screen=ncursesw --enable-locale-charset
	make
	make install-full
	chgrp -v -R root /usr/share/doc/$(NM)-$(VRS)/lynx_doc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
