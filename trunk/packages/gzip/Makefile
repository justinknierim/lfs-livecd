# Gzip Makefile

# Package versions
NM= gzip
VRS= 1.3.5
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-security_fixes-1.patch
URL= $(HTTP)/$(NM)/$(FILE)
URL1= $(HTTP)/$(NM)/$(PATCH)

# RULES

.PHONY: stage1 clean chroot stage2

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/gzip ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=$(WD) && make -j3 && make install ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv2) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -f /bin/gzip ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH) && \
	 ./configure --prefix=/usr && \
	 sed -i 's@"BINDIR"@/bin@g' gzexe.in && \
	 make -j3 && make install && \
	 mv /usr/bin/gzip /bin && \
	 rm /usr/bin/{gunzip,zcat} && \
	 ln -s gzip /bin/gunzip && \
	 ln -s gzip /bin/zcat && \
	 ln -s gunzip /bin/uncompress ; fi
	@make clean
	
clean:
	@-rm -rf $(DIR)
