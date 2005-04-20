# PCI Utilities Makefile

# Package versions
NM= pciutils
VRS= 2.1.11
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://www.kernel.org/pub/software/utils/$(NM)/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/sbin/lspci ] ; then tar -xjvf $(FILE) && cd $(DIR) && \
	 make PREFIX=/usr && \
	 make PREFIX=/usr install && \
	 update-pciids ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
