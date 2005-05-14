# popt Makefile

# Package versions
NM= popt
VRS= 1.7
DIR= $(NM)-$(VRS)
FILE= $(NM)_$(VRS).orig.tar.gz
PATCH1= $(NM)_$(VRS)-5.diff
URL= http://ftp.debian.org/debian/pool/main/p/$(NM)/$(FILE)
URL1= http://ftp.debian.org/debian/pool/main/p/$(NM)/$(PATCH1).gz

# RULES

.PHONY: clean stage2 chroot

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f $(PATCH1).gz ]  ; then $(WGET) $(URL1) ; fi
	@if [ ! -f $(PATCH1) ] ; then gunzip $(PATCH1).gz ; fi
	@if [ ! -f /usr/lib/libpopt.a ] ; then tar xzvf $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH1) && \
	 ./configure --prefix=/usr && \
	 cp configure.in configure.ac && \
	 touch configure.in configure.ac && \
	 make -j3 && make install ; fi
	@make clean
	 
clean:
	@-rm -rf $(DIR)
