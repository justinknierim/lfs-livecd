# XFS Progs Makefile

# Package versions
NM= xfsprogs
VRS= 2.6.25
DIR= $(NM)-$(VRS)
FILE= $(DIR).src.tar.gz
URL= ftp://oss.sgi.com/projects/xfs/download/cmd_tars/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /sbin/mkfs.xfs ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(DIR)-fix_compile-1.patch && \
	 sed -i 's/autoconf//' Makefile && \
	 make && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
