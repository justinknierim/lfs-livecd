# Dialog Makefile

# Package versions
NM= dialog
VRS= 1.0-20050306
DIR= $(NM)-$(VRS)
FILE= $(DIR).tgz
URL= ftp://invisible-island.net/dialog/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/dialog ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --enable-nls && make && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
