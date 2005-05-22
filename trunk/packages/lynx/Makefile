# Lynx Makefile

# Package versions
NM= lynx
VRS= 2.8.5
DIR= $(NM)2-8-5
FILE= $(NM)$(VRS).tar.bz2
URL= http://lynx.isc.org/release/$(FILE)



#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/lynx ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --libdir=/etc --with-zlib --with-bzlib \
	    --enable-nls --with-ssl --enable-charset-choice \
	    --enable-locale-charset && \
	 make -j3 && make install && \
	 sed -i 's/#LOCALE_CHARSET:FALSE/LOCALE_CHARSET:TRUE/' /etc/lynx.cfg && \
	 make docdir=/usr/share/doc/$(NM)-$(VRS)/lynx_doc helpdir=/usr/share/doc/$(NM)-$(VRS)/lynx_help install-doc && \
	 make docdir=/usr/share/doc/$(NM)-$(VRS)/lynx_doc helpdir=/usr/share/doc/$(NM)-$(VRS)/lynx_help install-help && \
	 chgrp -R root /usr/share/doc/$(NM)-$(VRS)/lynx_doc ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
