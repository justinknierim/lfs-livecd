# GCC Makefile

# Package versions
NM= gcc
VRS= 3.4.3
DIR= $(NM)-$(VRS)
FILE1= $(NM)-core-$(VRS).tar.bz2
FILE2= $(NM)-g++-$(VRS).tar.bz2
DLP1= $(MKTREE)/$(SRC)/$(FILE1)
DLP2= $(MKTREE)/$(SRC)/$(FILE2)
DLP3= $(MKTREE)/$(SRC)/$(PATCH1)
DLP4= $(MKTREE)/$(SRC)/$(PATCH2)
PATCH1= $(NM)-$(VRS)-no_fixincludes-1.patch
PATCH2= $(NM)-$(VRS)-specs-2.patch
URL1= $(FTP)/$(NM)/$(FILE1)
URL2= $(FTP)/$(NM)/$(FILE2)
URL3= $(FTP)/$(NM)/$(PATCH1)
URL4= $(FTP)/$(NM)/$(PATCH2)
WGET= wget -c --passive-ftp -O
WGET1= $(WGET) $(DLP1) $(URL1)
WGET2= $(WGET) $(DLP2) $(URL2)
WGET3= $(WGET) $(DLP3) $(URL3)
WGET4= $(WGET) $(DLP4) $(URL4)

#RULES
pre1:
	@su - lfs -c "exec env -i CFLAGS=' $(CFLAGS) ' LFS=$(MP) LC_ALL=POSIX PATH=$(WD)/bin:/bin:/usr/bin \
	 /bin/bash -c 'set +h && umask 022 && cd $(MKTREE) && make lfs-$(NM)-pass1'"

pre2:
	@su - lfs -c "exec env -i CFLAGS=' $(CFLAGS) ' LFS=$(MP) LC_ALL=POSIX PATH=$(WD)/bin:/bin:/usr/bin \
	 /bin/bash -c 'set +h && umask 022 && cd $(MKTREE) && make lfs-$(NM)-pass2'"
	
pass1:
	@echo ""
	@echo "=====> Building $(NM) Pass 1"
	@echo ""
	@if [ ! -f $(DLP1) ] ; then $(WGET1) ; fi
	if [ ! -f $(WD)/bin/$(NM) ] ; then tar xjvf $(DLP1) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --libexecdir=$(WD)/lib --with-local-prefix=$(WD) \
	 --disable-nls --enable-shared && make -j3 BOOT_LDFLAGS="-static" bootstrap && \
	 make install && ln -s gcc $(WD)/bin/cc ; fi
	@make clean

pass2:
	@echo ""
	@echo "=====> Building $(NM) Pass 2"
	@echo ""
	@if [ ! -f $(DLP1) ] ; then $(WGET1) ; fi
	@if [ ! -f $(DLP2) ] ; then $(WGET2) ; fi
	@if [ ! -f $(DLP3) ] ; then $(WGET3) ; fi
	@if [ ! -f $(DLP4) ] ; then $(WGET4) ; fi
	@if [ ! -f .pass2 ] ; then tar xjvf $(DLP1) && tar xjvf $(DLP2) && cd $(DIR) && \
	 patch -Np1 -i $(DLP3) && patch -Np1 -i $(DLP4) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --libexecdir=$(WD)/lib --with-local-prefix=$(WD) --enable-clocale=gnu \
	 --enable-shared --enable-threads=posix --enable-__cxa_atexit --enable-languages=c,c++ --disable-libstdcxx-pch && \
	make -j3 && make install ; fi
	@make clean
	@touch .pass2

clean:
	@-rm -rf $(DIR)
	@-rm -rf $(NM)-build
