# libjpeg Makefile

# Package versions
NM= libjpeg
VRS= 6b
DIR= jpeg-$(VRS) 
FILE= jpegsrc.v$(VRS).tar.gz
URL= http://www.ijg.org/files/$(FILE)


#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/lib/libjpeg.so ] ; then unpack $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --enable-static --enable-shared && \
	 make -j3 && make install && /sbin/ldconfig ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
