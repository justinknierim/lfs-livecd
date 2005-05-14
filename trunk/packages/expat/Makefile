# Expat Makefile

# Package versions
NM= expat
VRS= 1.95.8
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://easynews.dl.sourceforge.net/sourceforge/expat/$(FILE)



#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/xmlwf ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
