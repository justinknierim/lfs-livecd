# Fluxbox Makefile

# Package versions
NM= fluxbox
VRS= 0.9.12
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://voxel.dl.sourceforge.net/sourceforge/fluxbox/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/fluxbox ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install ; fi
	@cp -ra $(ROOT)/root/.fluxbox /root
	@cp $(ROOT)/root/.xinitrc /root
	@make clean

clean:
	@-rm -rf $(DIR)
