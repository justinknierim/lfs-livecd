# Tcl Makefile

# Package versions
NM= tcl
VRS= 8.4.9
DIR= $(NM)$(VRS)
FILE= $(DIR)-src.tar.bz2
DLP= $(MKTREE)/$(SRC)/$(FILE)
URL= $(FTP)/$(NM)/$(FILE)
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
	@if [ ! -f $(WD)/bin/tclsh ] ; then tar xjvf $(DLP) && cd $(DIR) && \
	 cd unix && ./configure --prefix=$(WD) && make -j3 && make install && ln -s tclsh8.4 $(WD)/bin/tclsh ; fi

clean:
	@-rm -rf $(DIR)
