# Coreutils Makefile

# Package versions
NM= coreutils
VRS= 5.2.1
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
	@if [ ! -f $(WD)/bin/ls ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 DEFAULT_POSIX2_VERSION=199209 ./configure --prefix=$(WD) && make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
