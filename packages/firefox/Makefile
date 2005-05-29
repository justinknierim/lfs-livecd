# Firefox Makefile

# Package versions
NM= firefox
VRS= 1.0.4
DIR= mozilla
FILE= $(NM)-$(VRS)-source.tar.bz2
URL= http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$(VRS)/source/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/firefox ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 sed 's!@TOPSRCDIR@!$(ROOT)/$(PKG)/$(NM)/mozilla!' ../.mozconfig > .mozconfig && \
	 make -f client.mk build && make -f client.mk install && \
	 cd $(ROOT)/$(PKG)/$(NM) && \
	 cp -ra $(ROOT)/root/.mozilla /root ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
