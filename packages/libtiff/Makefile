# libtiff Makefile

# Package versions
NM= tiff
VRS= 3.7.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://libtiff.maptools.org/dl/$(FILE)


#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-lib$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/lib/libtiff.so.3 ] ; then unpack $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
