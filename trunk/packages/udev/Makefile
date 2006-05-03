# Udev Makefile

NM= udev
VRS= 091
CONFVRS= 20060502-try2
DIR= $(NM)-$(VRS)
CONFDIR=$(NM)-config-$(CONFVRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/utils/kernel/hotplug/$(FILE)
SHA-$(FILE)= d6c9ad0fd86df80f5e6228ce529de1a2c1427a85

CONFIG1= $(CONFDIR).tar.bz2
URL-$(CONFIG1)= http://downloads.linuxfromscratch.org/$(CONFIG1)
SHA-$(CONFIG1)= 55690045db2d3cf70f5e46e11846494b6ccd33dc

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
ifndef CROSS
	make EXTRAS="`echo extras/*/`"
else
	make CC="gcc $(64FLAGS)" LD="gcc $(64FLAGS)" \
	 EXTRAS="`echo extras/*/`"
endif
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
