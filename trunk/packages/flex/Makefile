# Flex Makefile

# Package versions
NM= flex
VRS= 2.5.31
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-debian_fixes-2.patch
DLP= $(MKTREE)/$(SRC)/$(FILE)
DLP1= $(MKTREE)/$(SRC)/$(PATCH)
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH)
WGET= wget -c --passive-ftp -O $(DLP) $(URL)
WGET1= wget -c --passive-ftp -O $(DLP1) $(URL1)

#RULES

pre1:
	@su - lfs -c "exec env -i CFLAGS=' $(CFLAGS) ' LFS=$(MP) LC_ALL=POSIX PATH=$(WD)/bin:/bin:/usr/bin \
	 /bin/bash -c 'set +h && umask 022 && cd $(MKTREE) && make lfs-$(NM)'"
stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(DLP) ] ; then $(WGET) ; fi
	@if [ ! -f $(DLP1) ] ; then $(WGET1) ; fi
	@if [ ! -f $(WD)/bin/flex ] ; then tar xjvf $(DLP) && cd $(DIR) && \
	 patch -Np1 -i $(DLP1) && touch doc/flex.1 && \
	 ./configure --prefix=$(WD) && make -j3 && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
