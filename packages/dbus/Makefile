# dbus Makefile

NM= dbus
VRS= 1.0.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://dbus.freedesktop.org/releases/dbus/$(FILE)
SHA-$(FILE)= 2870efd6ea0b5b0d14e52195f560238a74bb1e0e

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
	    --disable-python
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
