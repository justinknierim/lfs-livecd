# irssi Makefile

NM= irssi
VRS= 0.8.10-rc6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://irssi.org/files/$(FILE)
SHA-$(FILE)= 87c5ec8da11686e3eadb95fa5d7b25655add37bf

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

# WARNING: don't add --without-terminfo --with-ncurses to ./configure line!
# This breaks non-ASCII input.

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc
	make $(PM)
	make install
	cp -ra $(ROOT)/root/.irssi /root

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
