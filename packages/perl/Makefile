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

.PHONY: stage1 clean chroot stage2

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -d $(WD)/lib/perl5/$(VRS) ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH) && \
	 ./configure.gnu --prefix=$(WD) -Dstatic_ext='IO Fcntl POSIX' && \
	 make -j3 perl utilities && cp perl pod/pod2man $(WD)/bin && \
	 mkdir -p $(WD)/lib/perl5/$(VRS) && cp -R lib/* $(WD)/lib/perl5/$(VRS) ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /usr/bin/perl$(VRS) ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure.gnu --prefix=/usr -Dpager="/bin/less -isR" && \
	 make -j3 && make install ; fi
	@make clean
	
clean:
	@-rm -rf $(DIR)
