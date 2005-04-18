# OpenSSL Makefile

# Package versions
NM= openssl
VRS= 0.9.7f
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
PATCH=  $(DIR)-fix_manpages-1.patch
URL= http://www.openssl.org/source/$(FILE)
URL1= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WD)/bin/$(WGET) $(URL) ; fi
	@if [ ! -f $(PATCH) ] ; then $(WD)/bin/$(WGET) $(URL1) ; fi
	@if [ ! -d /etc/ssl ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH) && \
	 ./config --openssldir=/etc/ssl --prefix=/usr shared && \
	 sed -i 's/mcpu=pentium/mtune=i486/' Configure && \
	 sed -i 's/mcpu=pentium/mtune=i486/' Makefile && \
	 make -j3 MANDIR=/usr/share/man && make MANDIR=/usr/share/man install && \
	 cp -r certs /etc/ssl ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
