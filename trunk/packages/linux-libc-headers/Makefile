# Linux-Libc-Headers Makefile

# Package versions
NM= linux-libc-headers
VRS= 2.6.10.0
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
DLP= $(MKTREE)/$(SRC)/$(FILE)
URL= http://ep09.pld-linux.org/~mmazur/$(NM)/$(FILE)
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
	@if [ ! -d /tools/include/asm ] ; then tar xjvf $(DLP) && cd $(DIR) && \
	 cp -R include/asm-i386 $(WD)/include/asm && cp -R include/linux $(WD)/include ; fi
	@-rm -rf $(DIR)

clean:
	@-rm -rf $(DIR)
