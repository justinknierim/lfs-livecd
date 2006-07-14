# Udev Makefile

NM= udev
VRS= 096
CONFVRS= 20060712
DIR= $(NM)-$(VRS)
CONFDIR=$(NM)-config-$(CONFVRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 8d15b89fdf93ba84e2d33ff6061e140aed0a4dce

FILE1= $(CONFDIR).tar.bz2
URL-$(FILE1)= http://downloads.linuxfromscratch.org/$(FILE1)
SHA-$(FILE1)= 077121266d07d85056e30046ddefa64b1b366f95

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(CONFIG1)} $(LFSSRC)

compile-stage2:
	tar xf ../$(FILE1)
	install -dv /lib/{firmware,udev/devices/{pts,shm}}
	mknod -m0666 /lib/udev/devices/null c 1 3
	ln -sfv /proc/self/fd /lib/udev/devices/fd
	ln -sfv /proc/self/fd/0 /lib/udev/devices/stdin
	ln -sfv /proc/self/fd/1 /lib/udev/devices/stdout
	ln -sfv /proc/self/fd/2 /lib/udev/devices/stderr
	ln -sfv /proc/kcore /lib/udev/devices/core
	rm -rf extras/dasd_id
	make EXTRAS="`echo extras/*/`"
	make DESTDIR=/ EXTRAS="`echo extras/*/`" install
	cp $(CONFDIR)/[0-9]* /etc/udev/rules.d/
	echo 'ACTION=="add", BUS=="pci", SYSFS{class}=="0x030000", RUN+="detect-video"' >/etc/udev/rules.d/30-video.rules
	install -m755 ../detect-video /lib/udev
	install -m644 ../50-network.rules /etc/udev/rules.d/
	install -m644 -D docs/writing_udev_rules/index.html \
	 /usr/share/doc/$(DIR)/index.html

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
