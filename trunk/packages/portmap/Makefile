# portmap Makefile

# Package versions
NM= portmap
VRS= 5beta
DIR= $(NM)_$(VRS)
FILE= $(DIR).tar.gz
PATCH1= $(NM)-$(VRS)-compilation_fixes-3.patch
PATCH2= $(NM)-$(VRS)-glibc_errno_fix-1.patch
URL= ftp://ftp.porcupine.org/pub/security/$(FILE)
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
	@if [ ! -f /sbin/portmap ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH1) && \
	 patch -Np1 -i ../$(PATCH2) && \
	 make -j3 && \
	 make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
