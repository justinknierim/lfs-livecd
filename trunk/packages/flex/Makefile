# Flex Makefile

# Package versions
NM= flex
VRS= 2.5.31
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-debian_fixes-2.patch
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH)

# RULES

.PHONY: stage1 clean

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/flex ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH) && touch doc/flex.1 && \
	 ./configure --prefix=$(WD) && make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
