# Ncurses Makefile

# Package versions
NM= ncurses
VRS= 5.4
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
	@if [ ! -f $(WD)/bin/clear ] ; then tar xjvf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=$(WD) --with-shared --without-debug --without-ada --enable-overwrite && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
