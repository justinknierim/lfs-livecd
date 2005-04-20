# xfce Makefile

# Package versions
NM= xfce
VRS= 4.2.0
DIR= $(NM)-$(VRS)
FILE= $(DIR)-src-bz2.tar.bz2
URL= http://www.us.xfce.org/archive/xfce-4.2.0/fat_tarballs/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/startxfce4 ] ; then tar -xjvf $(FILE) && cd $(DIR)/src-bz2 && \
	 for i in `cat ../../list` ; do tar -xjvf $$i.tar.bz2 && cd $$i && \
	 ./configure --prefix=/usr --sysconfdir=/etc --enable-debug=no --enable-panel --enable-startup-notification && \
	 make -j3 && make install && cd .. ; done ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
