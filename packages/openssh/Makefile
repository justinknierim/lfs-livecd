# OpenSSH Makefile

NM= openssh
VRS= 4.4p1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://openbsd.md5.com.ar/pub/OpenBSD/OpenSSH/portable/$(FILE)
SHA-$(FILE)= 6a52b1dee1c2c9862923c0008d201d98a7fd9d6c

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	install -v -d -m700 /var/lib/sshd
	chown root:sys /var/lib/sshd
	./configure --prefix=/usr --sysconfdir=/etc/ssh --libexecdir=/usr/sbin \
	 --with-md5-passwords --with-privsep-path=/var/lib/sshd
	make
	make install-nokeys
	install -v -m755 -d /usr/share/doc/$(DIR)
	install -v -m644 INSTALL LICENCE OVERVIEW README* WARNING.RNG \
	 /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
