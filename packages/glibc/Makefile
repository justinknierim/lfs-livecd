# Glibc Makefile

# Package versions
NM= glibc
VRS= 20041011
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
DLP= $(MKTREE)/$(SRC)/$(FILE)
URL= $(FTP)/$(NM)/$(FILE)
WGET= wget -c --passive-ftp -O $(DLP) $(URL)

#RULES

pre1:
	@su - lfs -c "exec env -i CFLAGS=' $(CFLAGS) ' LFS=$(MP) LC_ALL=POSIX PATH=/tools/bin:/bin:/usr/bin \
	 /bin/bash -c 'set +h && umask 022 && cd $(MKTREE) && make lfs-$(NM)'"
stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(DLP) ] ; then $(WGET) ; fi
	@if [ ! -d /tools/bin/ldd ] ; then tar xjvf $(DLP) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --disable-profile --enable-add-ons --enable-kernel=2.6.0 \
	 --with-binutils=$(WD)/bin --without-gd --without-cvs --with-headers=$(WD)/include --disable-selinux && \
	 PARALLELMFLAGS=-j3 make && if [ ! -d $(WD)/etc ] ; then mkdir $(WD)/etc ; fi && \
	 touch $(WD)/etc/ld.so.conf && make install $ ; fi
	@-rm -rf $(NM)-build
	@-rm -rf $(DIR)

clean:
	@-rm -rf $(NM)-build
	@-rm -rf $(DIR)
