# Expect Makefile

# Package versions
NM= expect
VRS= 5.42.1
DIR= $(NM)-5.42
FILE= $(NM)-$(VRS).tar.bz2
PATCH= $(NM)-$(VRS)-spawn-1.patch
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH)

# RULES

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(MP)/$(DLP)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(MP)/$(DLP) ; fi
	@if [ ! -f $(MP)/$(DLP)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(MP)/$(DLP) ; fi
	@if [ ! -f $(WD)/bin/expect ] ; then tar xjvf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(MP)/$(DLP)/$(PATCH) && \
	 ./configure --prefix=$(WD) --with-tcl=$(WD)/lib --with-tclinclude=$(MP)/$(MKTREE)/$(PKG)/tcl/tcl8.4.9 --with-x=no && \
	 make -j3 && make SCRIPTS="" install ; fi
	@make clean
	@make -C ../tcl clean

clean:
	@-rm -rf $(DIR)
