# Samba Makefile

# Package versions
NM= samba
VRS= 3.0.10
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://us2.samba.org/samba/ftp/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/smbmount ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 cd source && \
	 ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --with-piddir=/var/run --with-fhs \
	 --with-smbmount && \
	 make && \
	 mkdir /usr/lib/samba && mkdir /var/lib/samba && mkdir /etc/samba && \
	 cp codepages/{upcase,lowcase,valid}.dat /usr/lib/samba && \
	 touch /etc/samba/smb.conf && \
	 cp bin/{smbmnt,smbmount,smbumount,smbclient} /usr/bin && \
	 cd client && \
	 gcc $(CFLAGS) -static mount.cifs.c -o mount.cifs && \
	 cp mount.cifs /usr/bin ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
