# GPM Makefile

# Package versions
NM= gpm
VRS= 1.20.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH1= $(DIR)-segfault-1.patch
PATCH2= $(DIR)-silent-1.patch
URL= ftp://arcana.linux.it/pub/gpm/$(FILE)
URL1= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH1)
URL2= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH2)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f $(PATCH1) ] ; then $(WGET) $(URL1) ; fi
	@if [ ! -f $(PATCH2) ] ; then $(WGET) $(URL2) ; fi
	@if [ ! -f /usr/sbin/gpm ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH1) && patch -Np1 -i ../$(PATCH2) && \
	 CFLAGS="" LDFLAGS="-lm" ./configure --prefix=/usr --sysconfdir=/etc && \
	 LDFLAGS="-lm" make -j3 && make install && \
	 cp conf/gpm-root.conf /etc && /sbin/ldconfig ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
