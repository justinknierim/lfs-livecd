# Syslog-ng Makefile

# Package versions
NM= syslog-ng
VRS= 1.6.5
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
	@if [ ! -d /etc/syslog-ng ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --sysconfdir=/etc && \
	 make -j3 && make install && \
	 cp -ra $(ROOT)/etc/syslog-ng /etc ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
