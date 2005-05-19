# mutt Makefile

# Package versions
NM= mutt
VRS= 1.4.2.1
DIR= $(NM)-$(VRS)
FILE= $(DIR)i.tar.gz
NNTP_PATCH= patch-$(VRS).vvv.nntp
URL= ftp://ftp.mutt.org/mutt/$(FILE)
URL1= http://mutt.org.ua/download/mutt-$(VRS)/$(NNTP_PATCH).gz

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f $(NNTP_PATCH) ] ; then $(WGET) $(URL1) && gunzip $(NNTP_PATCH).gz ; fi
	-groupadd mail
	@if [ ! -f /usr/bin/mutt ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(NNTP_PATCH) && \
	 ./configure --prefix=/usr --sysconfdir=/etc --enable-imap --enable-pop --enable-nntp --with-ssl && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
