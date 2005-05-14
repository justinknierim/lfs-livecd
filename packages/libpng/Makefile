# libpng Makefile

# Package versions
NM= libpng
VRS= 1.2.8
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-link_to_proper_libs-1.patch
URL= http://easynews.dl.sourceforge.net/sourceforge/libpng/$(FILE)
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
	@if [ ! -f /usr/lib/libpng.so ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH) && \
	 make prefix=/usr ZLIBINC=/usr/include ZLIBLIB=/usr/lib -f scripts/makefile.linux && \
	 make prefix=/usr install -f scripts/makefile.linux && \
	 /sbin/ldconfig ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
