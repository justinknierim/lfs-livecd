# Make Makefile

# Package versions
NM= make
VRS= 3.80
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

.PHONY: stage1 clean chroot stage2

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/make ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
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
	@if [ ! -f /usr/bin/make ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
