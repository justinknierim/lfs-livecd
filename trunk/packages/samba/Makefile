# Samba Makefile

NM= samba
VRS= 3.0.30
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 609c602d9a17ea05954fc9fc021cfd95227eaefb

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	cd source ; ./configure --prefix=/usr --sysconfdir=/etc \
	 --localstatedir=/var --with-piddir=/var/run \
	 --with-pammodulesdir=/lib/security --with-fhs \
	 --with-smbmount
	cd source ; make
	cd source ; make install
	mv -v /usr/lib/samba/libsmbclient.so /usr/lib
	ln -v -sf ../libsmbclient.so /usr/lib/samba
	ln -v -sf libsmbclient.so /usr/lib/libsmbclient.so.0
	chmod -v 644 /usr/include/lib{smbclient,msrpc}.h
	cd source ; install -v -m644 ../examples/smb.conf.default /etc/samba
	install -v -m755 -d /usr/share/doc/$(DIR)
	cd source ; install -v -m644 ../docs/*.pdf /usr/share/doc/$(DIR)
	ln -v -s ../../samba/swat  /usr/share/doc/$(DIR)
	install -m644 $(ROOT)/etc/samba/smb.conf /etc/samba

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
