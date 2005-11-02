# Samba Makefile

NM= samba
VRS= 3.0.20b
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 640ab64182be17c05a97a08e43cb3b936c90e92b

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
	mkdir /etc/samba
	install -m644 $(ROOT)/etc/samba/smb.conf /etc/samba
	cd source/client ; \
	 gcc $(CFLAGS) -static mount.cifs.c -o mount.cifs ; \
	 cp mount.cifs /usr/bin
	cd source ; make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
