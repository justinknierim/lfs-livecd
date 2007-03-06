# Samba Makefile

NM= samba
VRS= 3.0.24
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://us3.samba.org/$(NM)/ftp/old-versions/$(FILE)
SHA-$(FILE)= 216020b58abca191b8146f76f98a8bda3508fcd3

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
	cd source ; make install ; mv -v /usr/lib/samba/*.so /usr/lib
	mkdir -p /etc/samba
	install -m644 $(ROOT)/etc/samba/smb.conf /etc/samba

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
