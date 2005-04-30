# cvs Makefile

# Package versions
NM= cvs
VRS= 1.11.18
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-zlib-1.patch
URL= https://ccvs.cvshome.org/files/documents/19/534/$(FILE)
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
	@if [ ! -f /usr/bin/cvs ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH) && \
	 ./configure --prefix=/usr && \
	 make -j3 && \
	 make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
