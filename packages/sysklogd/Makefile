# Sysklogd Makefile

# Package versions
NM= sysklogd
VRS= 1.4.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH=$(DIR)-fixes-1.patch
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH)

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
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -f /etc/syslog.conf ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH) && \
	 make -j3 && make install && \
	 cp -ra $(ROOT)/etc/syslog.conf /etc ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
