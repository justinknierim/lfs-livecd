# Texinfo Makefile

# Package versions
NM= texinfo
VRS= 4.8
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
DLP= $(MKTREE)/$(SRC)/$(FILE)
URL= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
WGET= wget -c --passive-ftp -O $(DLP) $(URL)

#RULES

pre1:
	@su - lfs -c "exec env -i CFLAGS=' $(CFLAGS) ' LFS=$(MP) LC_ALL=POSIX PATH=$(WD)/bin:/bin:/usr/bin \
	 /bin/bash -c 'set +h && umask 022 && cd $(MKTREE) && make lfs-$(NM)'"
stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(DLP) ] ; then $(WGET) ; fi
	@if [ ! -f $(WD)/bin/info ] ; then tar xjvf $(DLP) && cd $(DIR) && \
	 ./configure --prefix=$(WD) && make && make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
