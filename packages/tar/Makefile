# Tar Makefile

# Package versions
NM= tar
VRS= 1.15.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH=$(DIR)-sparse_fix-1.patch
URL= $(FTP)/$(NM)/$(FILE)
URL1=$(FTP)/$(NM)/$(PATCH)

# RULES

.PHONY: stage1 clean chroot stage2

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/tar ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=$(WD) && make -j3 && make install ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv2) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -f /bin/tar ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH) && \
	 ./configure --prefix=/usr --bindir=/bin --libexecdir=/usr/sbin && \
	 make -j3 && make install ; fi
	@make clean
	
clean:
	@-rm -rf $(DIR)
