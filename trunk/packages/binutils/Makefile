# Binutils Makefile

# Package versions
NM= binutils
VRS= 2.15.94.0.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
DLP= $(MKTREE)/$(SRC)/$(FILE)
URL= $(FTP)/$(NM)/$(FILE)
WGET= wget -c --passive-ftp -O $(DLP) $(URL)

#RULES

pre1:
	@su - lfs -c "exec env -i CFLAGS=' $(CFLAGS) ' LFS=$(MP) LC_ALL=POSIX PATH=/tools/bin:/bin:/usr/bin \
	 /bin/bash -c 'set +h && umask 022 && cd $(MKTREE) && make lfs-$(NM)-pass1'"
pass1:
	@echo ""
	@echo "=====> Building $(NM) Pass 1"
	@echo ""
	@if [ ! -f $(DLP) ] ; then $(WGET) ; fi
	if [ ! -f /tools/bin/ld ] ; then tar xjvf $(DLP) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --disable-nls && make configure-host && make -j3 LDFLAGS="-all-static" && \
	make install && make -C ld clean && make -j3 -C ld LDFLAGS="-all-static" LIB_PATH=/tools/lib ; fi

clean:
	@-rm -rf $(DIR)
	@-rm -rf $(NM)-build
