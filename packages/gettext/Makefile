# Gettext Makefile

# Package versions
NM= gettext
VRS= 0.14.3
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

.PHONY: stage1 clean chroot stage2

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/gettext ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=$(WD) --disable-libasprintf --without-csharp && make && make install ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	echo ""
	echo "=====> Building $(NM) in chroot"
	echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /usr/bin/gettext ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	./configure --prefix=/usr && make && make install ; fi
	@make clean
	
clean:
	@-rm -rf $(DIR)
