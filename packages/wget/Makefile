# Wget Makefile

# Package versions
NM= wget
VRS= 1.9.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
DLP= $(MKTREE)/$(SRC)/$(FILE)

#RULES
prebuild:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(DLP) ] ; then cd $(MKTREE)/$(SRC) && ftpget ; fi
	@if [ ! -f $(WD)/bin/$(NM) ] ; then \
	 tar xzf $(MKTREE)/$(SRC)/$(FILE) && cd $(DIR) && ./configure --prefix=$(WD) --libdir=$(WD)/lib --without-ssl && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
