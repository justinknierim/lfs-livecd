# Udev Makefile

NM= udev
VRS= 103
CONFVRS= 20061021
DIR= $(NM)-$(VRS)
CONFDIR=$(NM)-config-$(CONFVRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 015372f585beeba05217ad6568178820b2713571

FILE1= $(CONFDIR).tar.bz2
URL-$(FILE1)= $(HTTP)/$(NM)-config/$(FILE1)
SHA-$(FILE1)= 11b85243e0eec64be63be9e743f1ba7441a47e62

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
	cp -v etc/udev/rules.d/[0-9]* /etc/udev/rules.d/
	cd $(CONFDIR) ; make install install-doc install-extra-doc
	rm /etc/udev/rules.d/81-cdrom.rules
	echo 'ACTION=="add", SUBSYSTEM=="block", ENV{ID_TYPE}=="cd", IMPORT{program}="cdrom_id --export $tempnode", GROUP="cdrom"' >/etc/udev/rules.d/61-cdrom.rules
	echo 'ACTION=="add", BUS=="pci", ATTR{class}=="0x030000", RUN+="detect-video"' >/etc/udev/rules.d/30-video.rules
	install -m755 ../detect-video ../dhcp-helper /lib/udev
	install -m644 ../76-network.rules /etc/udev/rules.d/
	install -m644 -D docs/writing_udev_rules/index.html \
	 /usr/share/doc/$(DIR)/index.html

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
