# distcc Makefile

# Package versions
NM= distcc
VRS= 2.18.3
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://distcc.samba.org/ftp/$(NM)/$(FILE)

# RULES

.PHONY: clean stage2 chroot

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/distcc ] ; then unpack $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install ; fi
	@make clean
	 
clean:
	@-rm -rf $(DIR)
