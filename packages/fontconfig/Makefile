# Fontconfig Makefile

# Package versions
NM= fontconfig
VRS= 2.2.3
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://fontconfig.org/release/$(FILE)


#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -d /etc/fonts ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --sysconfdir=/etc --disable-docs && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
