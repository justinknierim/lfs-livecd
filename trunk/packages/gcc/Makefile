# GCC Makefile

# Package versions
NM= gcc
VRS= 3.4.3
DIR= $(NM)-$(VRS)
FILE1= $(NM)-core-$(VRS).tar.bz2
FILE2= $(NM)-g++-$(VRS).tar.bz2
DLP1= $(MKTREE)/$(SRC)/$(FILE1)
URL1= $(FTP)/$(NM)/$(FILE1)
WGET= wget -c --passive-ftp -O
WGET1= $(WGET) $(DLP1) $(URL1)

#RULES
pre1:
	@su - lfs -c "exec env -i CFLAGS=' $(CFLAGS) ' LFS=$(MP) LC_ALL=POSIX PATH=/tools/bin:/bin:/usr/bin \
	 /bin/bash -c 'set +h && umask 022 && cd $(MKTREE) && make lfs-$(NM)-pass1'"
	
pass1:
	@echo ""
	@echo "=====> Building $(NM) Pass 1"
	@echo ""
	@if [ ! -f $(DLP1) ] ; then $(WGET1) ; fi
	if [ ! -f /tools/bin/$(NM) ] ; then tar xjvf $(DLP1) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --libexecdir=$(WD)/lib --with-local-prefix=$(WD) \
	 --disable-nls --enable-shared && make -j3 BOOT_LDFLAGS="-static" bootstrap && \
	 make install && ln -s gcc $(WD)/bin/cc ; fi
	@-rm -rf $(DIR)
	@-rm -rf $(NM)-build

clean:
	@-rm -rf $(DIR)
	@-rm -rf $(NM)-build
