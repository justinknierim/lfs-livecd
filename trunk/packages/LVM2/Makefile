# lvm2 Makefile

# Package versions
NM= LVM2
VRS= 2.01.02
DIR= $(NM).$(VRS)
FILE= $(DIR).tgz
URL= ftp://sources.redhat.com/pub/lvm2/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/sbin/lvm ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && \
	 make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
