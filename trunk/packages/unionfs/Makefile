# Unionfs Makefile

# Package versions
NM= unionfs
VRS= 1.0.11
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= ftp://ftp.fsl.cs.sunysb.edu/pub/$(NM)/$(FILE)

# RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/sbin/unionctl ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 make KVERS=$(KVERS) PREFIX=/usr EXTRACFLAGS=-DNODEBUG && \
	 make KVERS=$(KVERS) PREFIX=/usr EXTRACFLAGS=-DNODEBUG install && \
	 strip --strip-debug /lib/modules/$(KVERS)/kernel/fs/unionfs.ko ; fi
	@make clean
	

clean:
	@-rm -rf $(DIR)
