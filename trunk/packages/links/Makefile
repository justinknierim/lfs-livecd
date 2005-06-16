# Links Makefile

# Package versions
NM= links
VRS= 2.1pre15
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= ftp://atrey.karlin.mff.cuni.cz/pub/local/clock/links/$(FILE)


#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/links ] ; then unpack $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --enable-graphics && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
