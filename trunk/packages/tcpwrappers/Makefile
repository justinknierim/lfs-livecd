# tcpwrappers Makefile

# Package versions
NM= tcpwrappers
VRS= 7.6
DIR= tcp_wrappers_$(VRS)
FILE= $(DIR).tar.gz
PATCH1= tcp_wrappers-$(VRS)-shared_lib_plus_plus-1.patch
PATCH2= tcp_wrappers-$(VRS)-gcc34-1.patch
URL= http://files.ichilton.co.uk/nfs/$(FILE)
URL1= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH1)
URL2= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH2)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f $(PATCH1) ] ; then $(WGET) $(URL1) ; fi
	@if [ ! -f $(PATCH2) ] ; then $(WGET) $(URL2) ; fi
	@if [ ! -f /usr/sbin/tcpd ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH1) && \
	 patch -Np1 -i ../$(PATCH2) && \
	 make -j3 REAL_DAEMON_DIR=/usr/sbin STYLE=-DPROCESS_OPTIONS linux && \
	 make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
