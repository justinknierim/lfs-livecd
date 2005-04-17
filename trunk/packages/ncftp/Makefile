# ncftp Makefile

# Package versions
NM= ncftp
VRS= 3.1.7
DIR= $(NM)-$(VRS)
FILE= $(DIR)-src.tar.bz2
URL= ftp://ftp.fu-berlin.de/unix/linux/mirrors/gentoo/distfiles/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/sbin/pppd ] ; then tar -xjvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -C libncftp shared && make -C libncftp soinstall &&
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
