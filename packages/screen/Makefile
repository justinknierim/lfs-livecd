# Screen Makefile

# Package versions
NM= screen
VRS= 4.0.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://ftp.gnu.org/gnu/screen/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/screen ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --with-socket-dir=/var/run/screen --with-sys-screenrc=/etc/screenrc && \
	 sed -i -e "s@/usr/local/etc/screenrc@/etc/screenrc@" {etc,doc}/* && \
	 make -j3 && make install && install -m 644 etc/etcscreenrc /etc/screenrc ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
