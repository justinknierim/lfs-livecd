# Util-Linux Makefile

# Package versions
NM= util-linux
VRS= 2.12q
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-cramfs-1.patch
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH)

# RULES

.PHONY: stage1 clean chroot stage2

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/mount ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 sed -i 's@/usr/include@$(WD)/include@g' configure && \
	 ./configure && make -j3 -C lib && make -j3 -C mount mount umount && \
	 make -j3 -C text-utils more && cp mount/{,u}mount text-utils/more $(WD)/bin ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv2) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -f /bin/mount ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 sed -i 's@etc/adjtime@var/lib/hwclock/adjtime@g' hwclock/hwclock.c && \
	 patch -Np1 -i $(SRC)/$(PATCH) && ./configure && \
	 make -j3 HAVE_KILL=yes HAVE_SLN=yes && \
	 make HAVE_KILL=yes HAVE_SLN=yes install ; fi
	@make clean
	

clean:
	@-rm -rf $(DIR)
