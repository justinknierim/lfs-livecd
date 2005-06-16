# OpenSSH Makefile

# Package versions
NM= openssh
VRS= 3.9p1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://sunsite.ualberta.ca/pub/OpenBSD/OpenSSH/portable/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@-install -v -d -m700 /var/lib/sshd
	@chown root:sys /var/lib/sshd
	@-groupadd sshd
	@-useradd -c sshd -d /var/lib/sshd -g sshd -s /bin/false sshd
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/ssh ] ; then unpack $(FILE) && cd $(DIR) && \
	 sed -i "s:-lcrypto:/usr/lib/libcrypto.a:g" configure && \
	 ./configure --prefix=/usr --sysconfdir=/etc/ssh --libexecdir=/usr/sbin --with-md5-passwords \
	 --with-privsep-path=/var/lib/sshd && \
	 make -j3 && make install-nokeys ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
