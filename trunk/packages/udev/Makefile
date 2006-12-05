# Udev Makefile

NM= udev
VRS= 096
CONFVRS= 6.2
DIR= $(NM)-$(VRS)
CONFDIR=$(NM)-config-$(CONFVRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 8d15b89fdf93ba84e2d33ff6061e140aed0a4dce

FILE1= $(CONFDIR).tar.bz2
URL-$(FILE1)= http://www.linuxfromscratch.org/lfs/downloads/6.2/$(FILE1)
SHA-$(FILE1)= 5cd22b8e9cf1e996871e2bc540d75e57a4f706a3

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(FILE1)} $(LFSSRC)

compile-stage2:
	tar xf ../$(FILE1)
	install -dv /lib/{firmware,udev/devices/{pts,shm}}
	mknod -m0666 /lib/udev/devices/null c 1 3 || true
	ln -nsfv /proc/self/fd /lib/udev/devices/fd
	ln -nsfv /proc/self/fd/0 /lib/udev/devices/stdin
	ln -nsfv /proc/self/fd/1 /lib/udev/devices/stdout
	ln -nsfv /proc/self/fd/2 /lib/udev/devices/stderr
	ln -nsfv /proc/kcore /lib/udev/devices/core
	rm -rf extras/dasd_id
	make EXTRAS="`echo extras/*/`"
	make DESTDIR=/ EXTRAS="`echo extras/*/`" install
	cp $(CONFDIR)/[0-9]* /etc/udev/rules.d/
	echo 'ACTION=="add", BUS=="pci", SYSFS{class}=="0x030000", RUN+="detect-video"' >/etc/udev/rules.d/30-video.rules
	install -m755 ../detect-video ../dhcp-helper /lib/udev
	install -m644 ../50-network.rules /etc/udev/rules.d/
	install -m644 -D docs/writing_udev_rules/index.html \
	 /usr/share/doc/$(DIR)/index.html

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
