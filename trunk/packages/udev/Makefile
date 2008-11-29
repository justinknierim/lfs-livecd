# Udev Makefile

NM= udev
VRS= 130
CONFVRS= 20081015
DIR= $(NM)-$(VRS)
CONFDIR=$(NM)-config-$(CONFVRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= da55d4064bd89d4cc3672a3ec304d82a12f0e39c

FILE1= $(CONFDIR).tar.bz2
URL-$(FILE1)= http://www.linuxfromscratch.org/lfs/downloads/6.4/$(FILE1)
SHA-$(FILE1)= 39818c2cc16744977ecac1bf96b9f99531d956b8

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
	mknod -m0600 /lib/udev/devices/kmsg c 1 11
	ln -nsfv /proc/self/fd /lib/udev/devices/fd
	ln -nsfv /proc/self/fd/0 /lib/udev/devices/stdin
	ln -nsfv /proc/self/fd/1 /lib/udev/devices/stdout
	ln -nsfv /proc/self/fd/2 /lib/udev/devices/stderr
	ln -nsfv /proc/kcore /lib/udev/devices/core
	./configure --prefix=/usr --exec-prefix= --sysconfdir=/etc
	make
	make install
	install -m644 -v rules/packages/64-*.rules /lib/udev/rules.d/
	install -m644 -v rules/packages/40-pilot-links.rules /lib/udev/rules.d/
	cd $(CONFDIR) ; make install install-doc install-extra-doc
	install -m644 -D docs/writing_udev_rules/index.html \
	 /usr/share/doc/$(DIR)/index.html
	#cp -v etc/udev/rules.d/[0-9]* /etc/udev/rules.d/
	#sed -i "s/ -M 0640//" $(CONFDIR)/25-lfs.rules
	#install -m755 ../dhcp-helper /lib/udev
	#install -m644 ../76-network.rules /etc/udev/rules.d/
	#echo 'SUBSYSTEM=="pnp", ENV{MODALIAS}!="?*", RUN+="/bin/sh -c '\''while read id; do /sbin/modprobe pnp:d$$$$id; done < /sys$$devpath/id'\''"' >>/etc/udev/rules.d/26-modprobe.rules

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
