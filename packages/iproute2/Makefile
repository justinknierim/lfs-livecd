# Iproute2 Makefile

# Package versions
NM= iproute2
VRS= 2.6.11
DATE= 050314
DIR= $(NM)-$(VRS)
FILE= $(NM)-$(VRS)-$(DATE).tar.bz2
PATCH= $(NM)-$(VRS)_$(DATE)-remove_db-1.patch
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH)

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
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -f /sbin/ip ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH) && \
	 ./configure && \
	 make -j3 SBINDIR=/sbin && make SBINDIR=/sbin install ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
