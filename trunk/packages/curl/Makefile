# Curl Makefile

# Package versions
NM= curl
VRS= 7.13.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://curl.haxx.se/download/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/curl ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install && \
	 find docs -name "Makefile*" -o -name "*.1" -o -name "*.3" | xargs rm && \
	 install -v -d -m755 /usr/share/doc/curl-7.12.3 && \
	 cp -v -R docs/* /usr/share/doc/curl-7.12.3 ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
