# LibUngif Makefile

# Package versions
NM= libungif
VRS= 4.1.3
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://easynews.dl.sourceforge.net/sourceforge/libungif/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/lib/libungif.so ] ; then unpack $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
