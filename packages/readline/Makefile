# Readline Makefile

# Package versions
NM= readline
VRS= 5.0
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-fixes-1.patch
URL= $(HTTP)/$(NM)/$(FILE)
URL1= $(HTTP)/$(NM)/$(PATCH)

# RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "======> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -f /usr/lib/libreadline.so ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH) && \
	 ./configure --prefix=/usr && \
	 make -j3 SHLIB_XLDFLAGS=-lncurses && make install && chmod 755 /usr/lib/*.5.0 && \
	 mv /usr/lib/lib{readline,history}.so.5* /lib && \
	 ln -sf ../../lib/libhistory.so.5 /usr/lib/libhistory.so && \
	 ln -sf ../../lib/libreadline.so.5 /usr/lib/libreadline.so ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
