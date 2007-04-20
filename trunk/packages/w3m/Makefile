# W3M Makefile

NM= w3m
VRS= 0.5.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://heanet.dl.sourceforge.net/sourceforge/$(NM)/$(FILE)
SHA-$(FILE)= 7da299648c236772bcde9b0e92e23346c8af0aca

PATCH1= $(DIR)-gpm_fix-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH1)
SHA-$(PATCH1)= 3480a66f8bcdb1d97d082f5c8a9ef7892914c9f1
# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	autoconf
	./configure --prefix=/usr --libexecdir=/usr/lib --sysconfdir=/etc \
	    --datarootdir=/usr/share --enable-image \
	    --with-mailer=/usr/bin/mutt --with-browser=/usr/bin/mozilla
	make datarootdir=/usr/share
	make datarootdir=/usr/share install
	install -v -D -m 644 doc/keymap.default /etc/w3m/keymap
	install -v -D -m 644 doc/menu.default /etc/w3m/menu
	install -v -d -m 755 /usr/share/doc/w3m-$(VRS)/html
	install -v -m 644 doc/{HISTORY,READM*,keymap.*,menu.*} /usr/share/doc/$(DIR)
	install -v -m 644 doc/*.html /usr/share/doc/$(DIR)/html

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
