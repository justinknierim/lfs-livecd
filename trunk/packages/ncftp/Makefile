# ncftp Makefile

# Package versions
NM= ncftp
VRS= 3.1.9
DIR= $(NM)-$(VRS)
FILE= $(DIR)-src.tar.bz2
URL= http://ftp.rge.com/pub/networking/$(NM)/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/$(NM) ] ; then unpack $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -C libncftp shared && make -C libncftp soinstall && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
