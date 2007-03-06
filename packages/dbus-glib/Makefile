# dbus-glib Makefile

NM= dbus-glib
VRS= 0.73
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://dbus.freedesktop.org/releases/dbus-glib/$(FILE)
SHA-$(FILE)= 31ad5dc7bed3111c1d21d9e9b53744a25c3e3556

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
