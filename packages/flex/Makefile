# Flex Makefile

# Package versions
NM= flex
VRS= 2.5.31
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-debian_fixes-2.patch
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
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/flex ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Z -Np1 -i $(SRC)/$(PATCH) && touch doc/flex.1 && \
	 ./configure --prefix=$(WD) && make -j3 && make install ; fi
	@make clean

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
	@if [ ! -f /usr/bin/flex ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Z -Np1 -i $(SRC)/$(PATCH) && touch doc/flex.1 && \
	 ./configure --prefix=/usr && make -j3 && make install && \
	 ln -sf libfl.a /usr/lib/libl.a && \
	 echo "#!/bin/sh" > /usr/bin/lex && \
	 echo "# Begin /usr/bin/lex" >> /usr/bin/lex && \
	 echo "" >> /usr/bin/lex && \
	 echo "exec /usr/bin/flex -l \"\$$@\"" >> /usr/bin/lex && \
	 echo "" >> /usr/bin/lex && \
	 echo "# End /usr/bin/lex" >> /usr/bin/lex && \
	 chmod 755 /usr/bin/lex ; fi
	@make clean
	
clean:
	@-rm -rf $(DIR)
