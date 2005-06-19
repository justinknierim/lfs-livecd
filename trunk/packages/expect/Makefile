# Expect Makefile

# Package versions
NM= expect
VRS= 5.43.0
DIR= $(NM)-5.43
FILE= $(NM)-$(VRS).tar.bz2
PATCH= $(NM)-$(VRS)-spawn-1.patch
URL= $(HTTP)/$(NM)/$(FILE)
URL1= $(HTTP)/$(NM)/$(PATCH)

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
	@if [ ! -f $(WD)/bin/expect ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH) && \
	 ./configure --prefix=$(WD) --with-tcl=$(WD)/lib --with-tclinclude=../../tcl/tcl8.4.9 --with-x=no && \
	 make -j3 && make SCRIPTS="" install ; fi
	@make clean
	@make -C ../tcl clean

clean:
	@-rm -rf $(DIR)
