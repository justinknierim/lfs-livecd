# Wget Makefile

# Package versions
NM= wget
VRS= 1.9.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz

#RULES
prebuild:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(MP)/$(DLP)/$(FILE) ] ; then cd $(MP)/$(DLP) && ftpget ; fi
	@if [ ! -f $(WD)/bin/$(NM) ] ; then \
	 tar xzf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && ./configure --prefix=$(WD) --libdir=$(WD)/lib --without-ssl && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
