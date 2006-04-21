# Udev Makefile

NM= udev
VRS= 088
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/utils/kernel/hotplug/$(FILE)
SHA-$(FILE)= 3a0fcf32aee14c36aa74172ec7d69c0d1b76b9dc

CONFIG1= $(NM)-config-6.rules
URL-$(CONFIG1)= http://downloads.linuxfromscratch.org/$(CONFIG1)
SHA-$(CONFIG1)= 4cc5382a0d7cca26f7ad342cbc7ed9d179c94ea5

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(CONFIG1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(CONFIG1)} $(LFSSRC)

compile-stage2:
ifndef CROSS
	make EXTRAS="`echo extras/*/`"
else
	make CC="gcc $(64FLAGS)" LD="gcc $(64FLAGS)" \
	 EXTRAS="`echo extras/*/`"
endif
	make DESTDIR=/ EXTRAS="`echo extras/*/`" install
	mkdir -p /lib/firmware
	grep -v cdrom $(SRC)/$(CONFIG1) >/etc/udev/rules.d/25-lfs.rules
	cp etc/udev/05-udev-early.rules /etc/udev/rules.d/
	echo 'ACTION=="add", BUS=="pci", SYSFS{class}=="0x030000", RUN+="detect-video"' >/etc/udev/rules.d/30-video.rules
	cp ../50-network.rules /etc/udev/rules.d/
	# Debug, remove before release
	gcc -o bug ../bug.c
	install -m755 bug /lib/udev
	echo 'ACTION=="add", RUN+="bug"' >/etc/udev/rules.d/90-debug.rules
	# End of debug
	mkdir -p /lib/udev/devices/pts
	ln -nsf /proc/self/fd /lib/udev/devices/fd
	ln -nsf /proc/self/fd/0 /lib/udev/devices/stdin
	ln -nsf /proc/self/fd/1 /lib/udev/devices/stdout
	ln -nsf /proc/self/fd/2 /lib/udev/devices/stderr
	ln -nsf /proc/kcore /lib/udev/devices/core
	install ../detect-video /lib/udev
	install -m644 -D docs/writing_udev_rules/index.html \
	 /usr/share/doc/$(DIR)/index.html

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
