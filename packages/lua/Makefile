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
	@if [ ! -f /usr/bin/lua ] ; then unpack $(FILE) && cd $(DIR) && \
	 sed -i 's@/usr/local@/usr@' config && \
	 make -j3 && make install && ldconfig ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
