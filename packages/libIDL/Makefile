# LibIDL Makefile

# Package versions
NM= libIDL
VRS= 0.8.4
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://ftp.gnome.org/pub/GNOME/sources/libIDL/0.8/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/lib/libIDL-2.so ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
