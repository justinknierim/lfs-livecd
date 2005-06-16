# Groff Makefile

# Package versions
NM= groff
VRS= 1.19.1
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
	@if [ ! -f /usr/bin/gtbl ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 PAGE=$(pagesize) ./configure --prefix=/usr && make && make install && \
	 ln -s soelim /usr/bin/zsoelim && ln -s eqn /usr/bin/geqn && \
	 ln -s tbl /usr/bin/gtbl ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
