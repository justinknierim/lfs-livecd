# Openbox Makefile

# Package versions
NM= openbox
VRS= 3.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://icculus.org/openbox/releases/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/openbox ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install ; fi
	@cp $(ROOT)/root/.xinitrc /root
	@make clean

clean:
	@-rm -rf $(DIR)
