# LibXML2 Makefile

# Package versions
NM= libxml2
VRS= 2.6.19
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://ftp.gnome.org/pub/GNOME/sources/libxml2/2.6/$(FILE)



#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/xmllint ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --with-history && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
