# Psmisc Makefile

# Package versions
NM= psmisc
VRS= 21.6
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

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
	@if [ ! -f /bin/killall ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --exec-prefix="" && \
	 make -j3 && make install && \
	 mv /bin/pstree* /usr/bin && ln -sf pstree /usr/bin/pstree.x11 ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
