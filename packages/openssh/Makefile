# OpenSSH Makefile

# Package versions
NM= openssh
VRS= 3.9p1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://sunsite.ualberta.ca/pub/OpenBSD/OpenSSH/portable/$(FILE)
HOST-ORIG= `hostname`

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -d /var/empty ] ; then mkdir /var/empty ; fi
	@hostname $(HOSTNAME)
	@if [ ! -f /usr/bin/ssh ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 chown root:sys /var/empty && \
	 groupadd sshd && \
	 useradd -c 'sshd privsep' -d /var/empty -g sshd -s /bin/false sshd && \
	 sed -i "s:-lcrypto:/usr/lib/libcrypto.a:g" configure && \
	 ./configure --prefix=/usr --sysconfdir=/etc/ssh --libexecdir=/usr/sbin --with-md5-passwords && \
	 make -j3 && make install ; fi
	@make clean
	@hostname $(HOST-ORIG)

clean:
	@-rm -rf $(DIR)
