# Gettext Makefile

# Package versions
NM= gettext
VRS= 0.14.1
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
	@if [ ! -f $(WD)/bin/gettext ] ; then tar xjvf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=$(WD) --disable-libasprintf --disable-csharp && make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
