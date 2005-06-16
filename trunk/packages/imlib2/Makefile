# ImLib2 Makefile

# Package versions
NM= imlib2
VRS= 1.1.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://easynews.dl.sourceforge.net/sourceforge/enlightenment/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -d /usr/share/doc/$(DIR) ] ; then unpack $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install && \
	 install -d -m755 /usr/share/doc/$(DIR) && \
	 install -m644 doc/{*.gif,index.html} /usr/share/doc/$(DIR) ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
