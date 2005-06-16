# Vim Makefile

# Package versions
NM= vim
VRS= 6.3
DIR= $(NM)63
FILE= $(NM)-$(VRS).tar.bz2
PATCH= $(NM)-$(VRS)-security_fix-1.patch
LANG_PACK= $(NM)-$(VRS)-lang.tar.bz2
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH)
URL2= $(FTP)/$(NM)/$(LANG_PACK)

# RULES

.PHONY: clean chroot stage2 stage3

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

chroot3:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-gvim $(chbash2)'

stage2:
	@echo ""
	@echo "======> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(LANG_PACK) ] ; then $(WGET) $(URL2) && \
	 mv $(LANG_PACK) $(SRC) ; fi
	@if [ ! -f /usr/bin/vi ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 unpack $(SRC)/$(LANG_PACK) --strip-components=1 && \
	 echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h && \
	 echo '#define SYS_GVIMRC_FILE "/etc/gvimrc"' >> src/feature.h && \
	 patch -Np1 -i $(SRC)/$(PATCH) && \
	 ./configure --prefix=/usr --enable-multibyte && \
	 make -j3 && make install && \
	 ln -sf vim /usr/bin/vi ; fi && cp $(ROOT)/etc/vimrc /etc
	@make clean

stage3:
	@echo ""
	@echo "======> Building $(NM) in chroot (stage 3)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(LANG_PACK) ] ; then $(WGET) $(URL2) && \
	 mv $(LANG_PACK) $(SRC) ; fi
	@if [ ! -f /usr/bin/gvim ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 unpack $(SRC)/$(LANG_PACK) --strip-components=1 && \
	 echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h && \
	 echo '#define SYS_GVIMRC_FILE "/etc/gvimrc"' >> src/feature.h && \
	 patch -Np1 -i $(SRC)/$(PATCH) && \
	 ./configure --prefix=/usr --with-features=huge && \
	 make -j3 && make install && \
	 ln -sf vim /usr/bin/vi ; fi && cp $(ROOT)/etc/vimrc /etc
	@make clean
clean:
	@-rm -rf $(DIR)
