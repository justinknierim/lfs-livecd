# Linux-Libc-Headers Makefile

# Package versions
NM= man-pages
VRS= 2.01
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

.PHONY: chroot stage2 clean

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(MKTREE) && make ch-man-pages $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -d /usr/share/man/man9 ] ; then unpack $(SRC)/$(FILE) && \
	 cd $(DIR) && make install ; fi
	@make clean
clean:
	@-rm -rf $(DIR)

