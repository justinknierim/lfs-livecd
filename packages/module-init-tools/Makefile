# Module-Init-Tools Makefile

# Package versions
NM= module-init-tools
VRS= 3.1
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
	@if [ ! -f /sbin/modprobe ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix="" --enable-zlib && \
	 make -j3 DOCBOOKTOMAN="" && make install ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
