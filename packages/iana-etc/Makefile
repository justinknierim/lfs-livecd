# Iana-etc Makefile

# Package versions
NM= iana-etc
VRS= 1.04
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

.PHONY: chroot stage2 clean

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /etc/protocols ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 make && make install ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
