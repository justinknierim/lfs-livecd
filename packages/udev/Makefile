# Udev Makefile

NM= udev
VRS= 113
CONFVRS= 6.3
DIR= $(NM)-$(VRS)
CONFDIR=$(NM)-config-$(CONFVRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/utils/kernel/hotplug/$(FILE)
SHA-$(FILE)= 55bea7ec61026b2ecc9d2013da0ef4eed76de948

FILE1= $(CONFDIR).tar.bz2
URL-$(FILE1)= http://www.linuxfromscratch.org/lfs/downloads/6.3/$(FILE1)
SHA-$(FILE1)= c21ade3df7c121694dd56668b0fdc2f3995e2779

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	$(std_build)

compile-stage2:
	tar xf ../$(FILE1)
	install -dv /lib/{firmware,udev/devices/{pts,shm}}
	mknod -m0666 /lib/udev/devices/null c 1 3 || true
	ln -nsfv /proc/self/fd /lib/udev/devices/fd
	ln -nsfv /proc/self/fd/0 /lib/udev/devices/stdin
	ln -nsfv /proc/self/fd/1 /lib/udev/devices/stdout
	ln -nsfv /proc/self/fd/2 /lib/udev/devices/stderr
	ln -nsfv /proc/kcore /lib/udev/devices/core
	make EXTRAS="`echo extras/*/`"
	make DESTDIR=/ EXTRAS="`echo extras/*/`" install
	cp -v etc/udev/rules.d/[0-9]* /etc/udev/rules.d/
	cd $(CONFDIR) ; make install install-doc install-extra-doc
	install -m755 ../dhcp-helper /lib/udev
	install -m644 ../76-network.rules /etc/udev/rules.d/
	install -m644 -D docs/writing_udev_rules/index.html \
	 /usr/share/doc/$(DIR)/index.html

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
