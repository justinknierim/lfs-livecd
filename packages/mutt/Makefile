# mutt Makefile

# Package versions
NM= mutt
VRS= 1.4.2.1
DIR= $(NM)-$(VRS)
FILE= $(DIR)i.tar.gz
URL= ftp://ftp.mutt.org/mutt/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/mutt ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 groupadd mail && \
	 ./configure --prefix=/usr --sysconfdir=/etc --enable-imap --enable-pop --with-ssl && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
