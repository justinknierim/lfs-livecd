# OpenSSL Makefile

# Package versions
NM= openssl
VRS= 0.9.7e
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://www.openssl.org/source/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WD)/bin/$(WGET) $(URL) ; fi
	@if [ ! -d /etc/ssl ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 sed 's/^passwd/openssl-passwd/' doc/apps/passwd.pod > doc/apps/openssl-passwd.pod && \
	 rm doc/apps/passwd.pod && mv doc/crypto/{,openssl_}threads.pod && \
	 ./config --openssldir=/etc/ssl --prefix=/usr shared && \
	 sed -i 's@SHLIBDIRS= fips crypto ssl@SHLIBDIRS= crypto ssl@g' Makefile && \
	 sed -i 's/mcpu=pentium/mtune=i486/' Configure && \
	 sed -i 's/mcpu=pentium/mtune=i486/' Makefile && \
	 make -j3 MANDIR=/usr/share/man && make MANDIR=/usr/share/man install && \
	 cp -r certs /etc/ssl ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
