# OpenSSH Makefile

NM= openssh
VRS= 4.7p1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 58357db9e64ba6382bef3d73d1d386fcdc0508f4

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
	sed -i 's@ -ldes@@' configure
	./configure --prefix=/usr --sysconfdir=/etc/ssh --datadir=/usr/share/sshd --libexecdir=/usr/lib/openssh \
	 --with-md5-passwords --with-privsep-path=/var/lib/sshd --with-xauth=/usr/bin/xauth
	make
	make install-nokeys
	install -v -m755 -d /usr/share/doc/$(DIR)
	install -v -m644 INSTALL LICENCE OVERVIEW README* WARNING.RNG \
	 /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
