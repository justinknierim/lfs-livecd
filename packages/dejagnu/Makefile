# DejaGNU Makefile

# Package versions
NM= dejagnu
VRS= 1.4.4
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
	@if [ ! -f $(WD)/bin/runtest ] ; then tar xjvf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=$(WD) && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
