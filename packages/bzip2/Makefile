# Bzip2 Makefile

# Package versions
NM= bzip2
VRS= 1.0.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

.PHONY: stage1 clean

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(MP)/$(DLP)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(MP)/$(DLP) ; fi
	@if [ ! -f $(WD)/bin/bzip2 ] ; then tar xjvf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && \
	 make -j3 && make PREFIX=$(WD) install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
