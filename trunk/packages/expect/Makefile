# Expect Makefile

# Package versions
NM= expect
VRS= 5.42.1
DIR= $(NM)-5.42
FILE= $(NM)-$(VRS).tar.bz2
PATCH= $(NM)-$(VRS)-spawn-1.patch
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
	@if [ ! -f $(WD)/bin/expect ] ; then tar xjvf $(DLP) && cd $(DIR) && \
	 patch -Np1 -i $(DLP1) && \
	 ./configure --prefix=$(WD) --with-tcl=$(WD)/lib --with-tclinclude=$(MKTREE)/$(PKG)/tcl/tcl8.4.9 --with-x=no && \
	 make -j3 && make SCRIPTS="" install ; fi
	@make clean
	@make -C ../tcl clean

clean:
	@-rm -rf $(DIR)
