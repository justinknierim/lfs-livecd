# CDRTools Makefile

# Package versions
NM= cdrtools
VRS= 2.01
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= ftp://ftp.berlios.de/pub/cdrecord/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f $(WD)/bin/mkisofs ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 make -j3 INS_BASE=$(WD) DEFINSUSR=root DEFINSGRP=root && \
	 make -j3 INS_BASE=$(WD) DEFINSUSR=root DEFINSGRP=root install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
