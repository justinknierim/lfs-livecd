# Sysklogd Makefile

# Package versions
NM= sysklogd
VRS= 1.6.20
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
	@if [ ! -d /etc/syslog-ng ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH) && \
	 make -j3 && make install && \
	 cp -ra $(ROOT)/etc/syslog-ng /etc ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
