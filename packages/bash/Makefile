# Bash Makefile

# Package versions
NM= bash
VRS= 3.0
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-avoid_WCONTINUED-1.patch
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
	@if [ ! -f $(WD)/bin/bash ] ; then tar xjvf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(MP)/$(DLP)/$(PATCH) && \
	 ./configure --prefix=$(WD) --without-bash-malloc && make -j3 && make install && \
	 ln -s bash $(WD)/bin/sh ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
