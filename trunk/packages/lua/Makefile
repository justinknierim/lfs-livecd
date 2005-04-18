# lua Makefile

# Package versions
NM= lua
VRS= 5.0.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://www.lua.org/ftp/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/sbin/pppd ] ; then tar -xzvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
