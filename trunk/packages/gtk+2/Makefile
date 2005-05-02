# Gtk+ Makefile

# Package versions
NM= gtk+
VRS= 2.6.7
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= ftp://ftp.gtk.org/pub/gtk/v2.6/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-gtk2 $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -d /usr/lib/gtk-2.0 ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --sysconfdir=/etc && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
