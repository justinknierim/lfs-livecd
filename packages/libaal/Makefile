# libaal Makefile

# Package versions
NM= libaal
VRS= 1.0.4
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://linuxberg.vc-graz.ac.at/mirror/reiserfs/reiser4progs/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/lib/libaal.so ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && \
	 make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
