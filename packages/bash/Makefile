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

.PHONY: stage1 clean

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/bash ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH) && \
	 ./configure --prefix=$(WD) --without-bash-malloc && make -j3 && make install && \
	 ln -s bash $(WD)/bin/sh ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
