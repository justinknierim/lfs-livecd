# Joe Makefile

# Package versions
NM= joe
VRS= 3.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://voxel.dl.sourceforge.net/sourceforge/joe-editor/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/joe ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --sysconfdir=/etc && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
