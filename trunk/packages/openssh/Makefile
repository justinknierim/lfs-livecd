# OpenSSH Makefile

NM= openssh
VRS= 4.2p1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://sunsite.ualberta.ca/pub/OpenBSD/OpenSSH/portable/$(FILE)
SHA-$(FILE)= 5e7231cfa8ec673ea856ce291b78fac8b380eb78

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
	sed -i "s:-lcrypto:/usr/lib/libcrypto.a:g" configure
	./configure --prefix=/usr --sysconfdir=/etc/ssh --libexecdir=/usr/sbin \
	 --with-md5-passwords --with-privsep-path=/var/lib/sshd
	make $(PM)
	make install-nokeys
	install -v -m755 -d /usr/share/doc/$(DIR)
	install -v -m644 INSTALL LICENSE OVERVIEW README* WARNING.RNG \
	 /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
