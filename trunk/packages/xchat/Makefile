# xchat Makefile

# Package versions
NM= xchat
VRS= 2.4.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://xchat.org/files/source/2.4/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/xchat ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install ; fi
	@cp -ra $(ROOT)/root/.xchat2 /root
	@make clean

clean:
	@-rm -rf $(DIR)
