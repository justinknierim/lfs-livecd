# Udev Makefile

NM= udev
VRS= 092
CONFVRS= 20060515
DIR= $(NM)-$(VRS)
CONFDIR=$(NM)-config-$(CONFVRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= d512e18d4f3a6f89b0d28bbba6510aa81e63d895

CONFIG1= $(CONFDIR).tar.bz2
URL-$(CONFIG1)= http://downloads.linuxfromscratch.org/$(CONFIG1)
SHA-$(CONFIG1)= f02c1d2b56e42a26a5650be0434a6c76ddb21f14

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(CONFIG1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(CONFIG1)} $(LFSSRC)

compile-stage2:
	tar xf ../$(CONFIG1)
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
	install -v -m 744 $(CONFDIR)/write_cd_aliases /lib/udev/
	echo 'ACTION=="add", BUS=="pci", SYSFS{class}=="0x030000", RUN+="detect-video"' >/etc/udev/rules.d/30-video.rules
	install -m755 ../detect-video /lib/udev
	install -m644 ../50-network.rules /etc/udev/rules.d/
	install -m644 -D docs/writing_udev_rules/index.html \
	 /usr/share/doc/$(DIR)/index.html
	# Debug, remove before release
	gcc -o bug ../bug.c
	install -m755 bug /lib/udev
	# End of debug

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
