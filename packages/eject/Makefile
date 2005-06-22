# eject Makefile

# Package versions
NM= eject
VRS= 2.1.0
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://www.ibiblio.org/pub/Linux/utils/disk-management/$(FILE)

# RULES

.PHONY: stage1 clean stage2 chroot

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /bin/eject ] ; then unpack $(FILE) && cd $(DIR) && \
	 ./bootstrap && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install ; fi
	@make clean
	 
# Does what it says
clean:
	@-rm -rf $(DIR)
