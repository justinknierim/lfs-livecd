# Perl Makefile

# Package versions
NM= perl
VRS= 5.8.6
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-libc-1.patch
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
	@if [ ! -f $(WD)/bin/perl ] ; then tar xjvf $(DLP) && cd $(DIR) && \
	 patch -Np1 -i $(DLP1) && \
	 ./configure.gnu --prefix=$(WD) -Dstatic_ext='IO Fcntl POSIX' && \
	 make -j3 perl utilities && cp perl pod/pod2man $(WD)/bin && \
	 mkdir -p $(WD)/lib/perl5/$(VRS) && cp -R lib/* $(WD)/lib/perl5/$(VRS) ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
