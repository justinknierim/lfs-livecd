# xorg-server Makefile

NM= xorg-server
VRS= 1.5.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 177529b6d7191a73df6abf2990cd7708398a8d81

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man --localstatedir=/var \
	 --with-module-dir=/usr/lib/X11/modules --with-xkb-output=/var/lib/xkb \
	 --enable-install-setuid
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
