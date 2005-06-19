# Patch Makefile

# Package versions
NM= patch
VRS= 2.5.4
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
	@if [ ! -f $(WD)/bin/patch ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 CPPFLAGS=-D_GNU_SOURCE ./configure --prefix=$(WD) && make -j3 && make install ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv2) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /usr/bin/patch ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 CPPFLAGS=-D_GNU_SOURCE ./configure --prefix=/usr && make -j3 && make install ; fi
	@make clean
	
clean:
	@-rm -rf $(DIR)
