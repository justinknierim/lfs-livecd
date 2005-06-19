# Zlib Makefile

# Package versions
NM= zlib
VRS= 1.2.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(HTTP)/$(NM)/$(FILE)

# RULES

.PHONY: chroot stage2 clean

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /usr/lib/libz.so ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --shared && \
	 make -j3 && make install && make clean && ./configure --prefix=/usr && \
	 make -j3 && make install && chmod 644 /usr/lib/libz.a && \
	 mv /usr/lib/libz.so.* /lib && \
	 ln -sf ../../lib/libz.so.1 /usr/lib/libz.so ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
