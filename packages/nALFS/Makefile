# nALFS Makefile

# Package versions
NM= nALFS
VRS= 1.2.4
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://www.linuxfromscratch.org/alfs/downloads/stable/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/nALFS ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --with-libxml2 --with-curl --with-ssl && \
	 make -j3 && \
	 make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
