# Perl Makefile

# Package versions
NM= perl
VRS= 5.8.6
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-libc-1.patch
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH)

# RULES

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(MP)/$(DLP)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(MP)/$(DLP) ; fi
	@if [ ! -f $(MP)/$(DLP)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(MP)/$(DLP) ; fi
	@if [ ! -d $(WD)/lib/perl5/$(VRS) ] ; then tar xjvf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(MP)/$(DLP)/$(PATCH) && \
	 ./configure.gnu --prefix=$(WD) -Dstatic_ext='IO Fcntl POSIX' && \
	 make -j3 perl utilities && cp perl pod/pod2man $(WD)/bin && \
	 mkdir -p $(WD)/lib/perl5/$(VRS) && cp -R lib/* $(WD)/lib/perl5/$(VRS) ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
