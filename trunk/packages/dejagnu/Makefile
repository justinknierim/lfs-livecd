# DejaGNU Makefile

# Package versions
NM= dejagnu
VRS= 1.4.4
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

.PHONY: stage1 clean

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/runtest ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=$(WD) && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
