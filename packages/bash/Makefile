# Bash Makefile

# Package versions
NM= bash
VRS= 3.0
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-avoid_WCONTINUED-1.patch
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
	@if [ ! -f $(WD)/bin/bash ] ; then tar xjvf $(DLP) && cd $(DIR) && \
	 patch -Np1 -i $(DLP1) && \
	 ./configure --prefix=$(WD) --without-bash-malloc && make -j3 && make install && \
	 ln -s bash $(WD)/bin/sh ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
