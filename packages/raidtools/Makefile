# raidtools Makefile

# Package versions
NM= raidtools
VRS= 1.00.3
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
PATCH1= $(DIR)-gcc-3.3_fix-1.patch
URL= http://people.redhat.com/mingo/$(NM)/$(FILE)

# RULES

.PHONY: clean stage2 chroot

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /sbin/mkraid ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH1) && \
	 ./configure --prefix=/usr --sysconfdir=/etc && \
	 make -j3 && make install ; fi
	@make clean
	 
clean:
	@-rm -rf $(DIR)
