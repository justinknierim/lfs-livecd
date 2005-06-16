# Thunderbird Makefile

# Package versions
NM= thunderbird
VRS= 1.0.2
DIR= mozilla
FILE= $(NM)-$(VRS)-source.tar.bz2
URL= http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/$(VRS)/source/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/thunderbird ] ; then unpack $(FILE) && cd $(DIR) && \
	 sed 's!@TOPSRCDIR@!$(ROOT)/$(PKG)/$(NM)/mozilla!' ../.mozconfig > .mozconfig && \
	 make -f client.mk build && make -f client.mk install && \
	 cd $(ROOT)/$(PKG)/$(NM) ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
