# Wget Makefile

# Package versions
NM= wget
VRS= 1.9.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz

#RULES

.PHONY: prebuild clean chroot stage2

prebuild:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(FILE) ] ; then ftpget ; fi
	@if [ ! -f $(WD)/bin/$(NM) ] ; then \
	 tar xzvf $(FILE) && cd $(DIR) && ./configure --prefix=$(WD) --libdir=$(WD)/lib --without-ssl \
	 --enable-static --disable-shared && \
	 make -j3 && make install ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WD)/bin/ftpget ; fi
	@if [ ! -f /usr/bin/$(NM) ] ; then \
	 tar xzvf $(FILE) && cd $(DIR) && ./configure --prefix=/usr && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
