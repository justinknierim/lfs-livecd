# Ncurses Makefile

# Package versions
NM= ncurses
VRS= 5.4
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

.PHONY: stage1 clean chroot stage2

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/clear ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=$(WD) --with-shared --without-debug --without-ada --enable-overwrite && \
	 make && make install ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "======> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /usr/bin/clear ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --with-shared --without-debug && \
	 make && make install && chmod 755 /usr/lib/*.5.4 && \
	 chmod 644 /usr/lib/libncurses++.a && mv /usr/lib/libncurses.so.5* /lib && \
	 ln -sf ../../lib/libncurses.so.5 /usr/lib/libncurses.so && \
	 ln -sf libncurses.so /usr/lib/libcurses.so ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
