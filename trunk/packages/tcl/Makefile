# Tcl Makefile

# Package versions
NM= tcl
VRS= 8.4.9
DIR= $(NM)$(VRS)
FILE= $(DIR)-src.tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

.PHONY: stage1 clean

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(MP)/$(DLP)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(MP)/$(DLP) ; fi
	@if [ ! -f $(WD)/bin/tclsh ] ; then tar xjvf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && \
	 cd unix && ./configure --prefix=$(WD) && make -j3 && make install && ln -s tclsh8.4 $(WD)/bin/tclsh ; fi

clean:
	@-rm -rf $(DIR)
