# Nano Makefile

# Package versions
NM= nano
VRS= 1.2.4
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://www.nano-editor.org/dist/v1.2/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/nano ] ; then unpack $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --sysconfdir=/etc --enable-color --enable-multibuffer \
	 --enable-nanorc && \
	 make -j3 && make install && \
	 mkdir -p /usr/share/doc/nano/examples && \
	 cp nanorc.sample /usr/share/doc/nano/examples && \
	 cp $(ROOT)/etc/nanorc /etc ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
