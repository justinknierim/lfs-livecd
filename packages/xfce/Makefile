# xfce Makefile

# Package versions
NM= xfce
VRS= 4.2.1.1
DIR= $(NM)-$(VRS)
FILE= $(DIR)-src.tar.bz2
URL= http://www.us.xfce.org/archive/xfce-4.2.1.1/fat_tarballs/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/startxfce4 ] ; then tar -xjvf $(FILE) && cd $(DIR)/src && \
	 for i in `cat ../../list` ; do tar -xzvf $$i.tar.gz && cd $$i && \
	 ./configure --prefix=/usr --sysconfdir=/etc --enable-debug=no --enable-panel --enable-startup-notification --libexecdir=/usr/sbin && \
	 make -j3 && make install && cd .. ; done ; fi
	@cp $(ROOT)/root/.xinitrc /root/
	@cp desktop-files/* /usr/share/applications
	@make clean

clean:
	@-rm -rf $(DIR)
