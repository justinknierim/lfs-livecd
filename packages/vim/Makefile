# Vim Makefile

# Package versions
NM= vim
VRS= 6.3
DIR= $(NM)63
FILE= $(NM)-$(VRS).tar.bz2
PATCH= $(NM)-$(VRS)-security_fix-1.patch
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH)

# RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "======> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -f /usr/bin/vi ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h && \
	 echo '#define SYS_GVIMRC_FILE "/etc/gvimrc"' >> src/feature.h && \
	 patch -Np1 -i $(SRC)/$(PATCH) && \
	 ./configure --prefix=/usr --enable-multibyte && \
	 make -j3 && make install && \
	 ln -s vim /usr/bin/vi ; fi && cp $(ROOT)/etc/vimrc /etc
	@make clean

clean:
	@-rm -rf $(DIR)
