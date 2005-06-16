# Bzip2 Makefile

# Package versions
NM= bzip2
VRS= 1.0.3
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
	@if [ ! -f $(WD)/bin/bzip2 ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 make -j3 && make PREFIX=$(WD) install ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv2) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /bin/bzip2 ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 make -j3 -f Makefile-libbz2_so && make clean && \
	 make -j3 && make install && \
	 cp bzip2-shared /bin/bzip2 && cp -a libbz2.so* /lib && \
	 ln -s ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so && \
	 rm /usr/bin/{bunzip2,bzcat,bzip2} && \
	 ln -s bzip2 /bin/bunzip2 && ln -s bzip2 /bin/bzcat ; fi
	@make clean
	

clean:
	@-rm -rf $(DIR)
