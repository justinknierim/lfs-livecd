# Zip Makefile

# Package versions
NM= zip
VRS= 2.3
DIR= $(NM)-$(VRS)
FILE= $(NM)23.tar.gz
URL= http://www.mirrorservice.org/sites/ftp.info-zip.org/pub/infozip/src/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/zip ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 make prefix=/usr -f unix/Makefile generic_gcc && \
	 make prefix=/usr -f unix/Makefile install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
