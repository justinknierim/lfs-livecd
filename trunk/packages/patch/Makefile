# Patch Makefile

# Package versions
NM= patch
VRS= 2.5.4
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(MP)/$(DLP)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(MP)/$(DLP) ; fi
	@if [ ! -f $(WD)/bin/patch ] ; then tar xjvf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && \
	 CPPFLAGS=-D_GNU_SOURCE ./configure --prefix=$(WD) && make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
