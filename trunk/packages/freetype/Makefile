# FreeType Makefile

# Package versions
NM= freetype
VRS= 2.1.9
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-bytecode_interpreter-1.patch
URL= http://voxel.dl.sourceforge.net/sourceforge/freetype/$(FILE)
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
	@if [ ! -f /usr/lib/libfreetype.so ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH) && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
