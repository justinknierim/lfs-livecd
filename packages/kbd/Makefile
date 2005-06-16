# Kbd Makefile

# Package versions
NM= kbd
VRS= 1.12
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)
PATCH= $(DIR)-backspace-1.patch

BELARUSIAN_FILE= belarusian-0.3.tar.gz
BELARUSIAN_URL= http://www.mova.org/bellinux/$(BELARUSIAN_FILE)

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
	@if [ ! -f $(BELARUSIAN_FILE) ] ; then $(WGET) $(BELARUSIAN_URL) ; fi
	@if [ ! -f /bin/loadkeys ] ; then unpack $(SRC)/$(FILE) && \
	 tar zxvf $(BELARUSIAN_FILE) && \
	 zcat bellinux/console/keymaps/by2_win.kmap.gz >$(DIR)/data/keymaps/i386/qwerty/by2_win.map && \
	 echo 'Correcting SOFT SIGN in by2_win keymap' && \
	 sed -i -e 's/\(50 = 0x.\)A/\1C/' $(DIR)/data/keymaps/i386/qwerty/by2_win.map && \
	 cd $(DIR) &&  patch -Np1 -i ../$(PATCH) && \
	 ./configure && make -j3 && make install ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
	@-rm -rf bellinux
