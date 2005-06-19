# Gawk Makefile

# Package versions
NM= gawk
VRS= 3.1.4
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(HTTP)/$(NM)/$(FILE)

# RULES

.PHONY: stage1 clean chroot stage2

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/gawk ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=$(WD) && make -j3 && make install ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /usr/bin/gawk ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --libexecdir=/usr/lib && \
	 make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
