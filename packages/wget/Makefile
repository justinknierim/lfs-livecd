# Wget Makefile

# Package versions
NM= wget
VRS= 1.9.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz

#RULES

.PHONY: prebuild clean

prebuild:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(FILE) ] ; then ftpget ; fi
	@if [ ! -f $(WD)/bin/$(NM) ] ; then \
	 tar xzf $(FILE) && cd $(DIR) && ./configure --prefix=$(WD) --libdir=$(WD)/lib --without-ssl \
	 --enable-static --disable-shared && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
