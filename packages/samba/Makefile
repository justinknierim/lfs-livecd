# Samba Makefile

NM= samba
VRS= 3.0.21a
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://us2.samba.org/$(NM)/ftp/old-versions/$(FILE)
SHA-$(FILE)= c8d339801f2f1c60a4bb652aee85da6a0eb5d224

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	cd source ; ./configure --prefix=/usr --sysconfdir=/etc \
	 --localstatedir=/var --with-piddir=/var/run --with-fhs \
	 --with-smbmount --without-sys-quotas --without-quotas
	cd source ; make
	mkdir -p /etc/samba
	install -m644 $(ROOT)/etc/samba/smb.conf /etc/samba
	cd source ; make client/mount.cifs
	# Don't do a full "make install" in order to save space.
	# We install:
	# 1) Programs that XFCE wants to execute: nmblookup,smbclient
	# 2) Programs for mounting: smbmnt, smbmount, smbumount
	# 3) Manual pages
	install -v -m755 source/bin/{nmblookup,smbclient,smbmount} /usr/bin
	install -v -m4755 source/bin/{smbmnt,smbumount} /usr/bin
	ln -svf /usr/bin/smbmount /sbin/mount.smbfs
	install -v -m4755 source/client/mount.cifs /sbin
	install -v -m644 docs/manpages/{nmblookup.1,smbclient.1} /usr/share/man/man1
	install -v -m644 docs/manpages/{lmhosts.5,smb.conf.5} /usr/share/man/man5
	install -v -m644 docs/manpages/samba.7 /usr/share/man/man7
	install -v -m644 docs/manpages/{mount.cifs.8,smbmnt.8,smbmount.8,smbumount.8} /usr/share/man/man8

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
