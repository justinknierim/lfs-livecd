# Texinfo Makefile

# Package versions
NM= texinfo
VRS= 4.8
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://ftp.gnu.org/gnu/$(NM)/$(FILE)

# RULES

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(MP)/$(DLP)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(MP)/$(DLP) ; fi
	@if [ ! -f $(WD)/bin/info ] ; then tar xjvf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=$(WD) && make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
