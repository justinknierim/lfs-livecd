# Inetutils Makefile

# Package versions
NM= inetutils
VRS= 1.4.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH1= $(DIR)-kernel_headers-1.patch
PATCH2= $(DIR)-no_server_man_pages-1.patch
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH1)
URL2= $(FTP)/$(NM)/$(PATCH2)

# RULES

.PHONY: chroot stage2 clean

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH1) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH1) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH2) ] ; then $(WGET) $(URL2) && \
	 mv $(PATCH2) $(SRC) ; fi
	@if [ ! -f /bin/ping ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH1) && patch -Np1 -i $(SRC)/$(PATCH2) && \
	 ./configure --prefix=/usr --libexecdir=/usr/sbin --sysconfdir=/etc \
	 --disable-logger --disable-syslogd --disable-whois --disable-servers && \
	 make -j3 && make install && mv /usr/bin/ping /bin ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
