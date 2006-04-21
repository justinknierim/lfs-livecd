# irssi Makefile

NM= irssi
VRS= 0.8.10
DIR= $(NM)-$(VRS)

FILE= $(DIR)a.tar.bz2
URL-$(FILE)= http://irssi.org/files/$(FILE)
SHA-$(FILE)= c27c3aa19f7e54e4295c9e78f522194b296e9f7f

PATCH1= $(DIR)-gslice-1.patch

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
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --sysconfdir=/etc
	make $(PM)
	make install
	cp -ra $(ROOT)/root/.irssi /root

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
