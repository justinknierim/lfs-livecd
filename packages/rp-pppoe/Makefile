# RP-pppoe Makefile

# Package versions
NM= rp-pppoe
VRS= 3.5
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
PATCH= $(DIR)-iproute2-1.patch
URL= http://www.roaringpenguin.com/penguin/pppoe/$(FILE)
URL1= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH)

# RULES

.PHONY:  clean stage2 chroot

chroot:
	@chroot "$(MP)" $(chenv2) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) ; fi
	@if [ ! -f /usr/sbin/pppoe ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH) && cd src && \
	 ./configure && make && \
	 make install ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
