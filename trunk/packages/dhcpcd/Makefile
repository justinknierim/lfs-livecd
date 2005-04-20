# dhcpcd Makefile

# Package versions
NM= dhcpcd
VRS= 1.3.22-pl4
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
PATCH= $(DIR)-fhs-1.patch
URL= http://www.phystech.com/ftp/$(FILE)
URL1= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f $(PATCH) ] ; then $(WGET) $(URL1) ; fi
	@if [ ! -f /sbin/dhcpcd ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH) && \
	 ./configure --prefix="" --sysconfdir=/var/lib --mandir=/usr/share/man && \
	 make -j3 && \
	 make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
