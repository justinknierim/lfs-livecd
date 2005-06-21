# Grep Makefile

# Package versions
NM= grep
VRS= 2.5.1a
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(HTTP)/$(NM)/$(FILE)

# RULES

.PHONY: stage1 clean chroot stage2

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/grep ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=$(WD) --disable-perl-regexp && \
	 make -j3 && make install ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv2) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /bin/grep ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --bindir=/bin && \
	 make -j3 && make install ; fi
	@make clean
	

clean:
	@-rm -rf $(DIR)
