# Less Makefile

# Package versions
NM= less
VRS= 382
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "======> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /bin/less ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --bindir=/bin -sysconfdir=/etc && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
