# Kbd Makefile

# Package versions
NM= kbd
VRS= 1.12
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH1)

# RULES

.PHONY:  clean stage2 chroot

chroot:
	@chroot "$(MP)" $(chenv2) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /bin/loadkeys ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure && make -j3 && make install ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
