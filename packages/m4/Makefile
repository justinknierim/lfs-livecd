# M4 Makefile

# Package versions
NM= m4
VRS= 1.4.2
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
	@if [ ! -f $(WD)/bin/m4 ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=$(WD) && make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
