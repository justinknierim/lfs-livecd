# slrn Makefile

# Package versions
NM= slrn
VRS= 0.9.8.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://voxel.dl.sourceforge.net/sourceforge/$(NM)/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/slrn ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --sysconfdir=/etc --with-slrnpull --enable-spool --with-ssl && \
	 make -j3 && make install && \
	 cp $(ROOT)/root/.slrnrc /root/ && \
	 NNTPSERVER=news.linuxfromscratch.org slrn -f ~/.jnewsrc --create ; fi

clean:
	@-rm -rf $(DIR)
