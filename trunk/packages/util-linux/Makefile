# Util-Linux Makefile

# Package versions
NM= util-linux
VRS= 2.12p
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
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
	@if [ ! -f $(WD)/bin/mount ] ; then tar xjvf $(DLP) && cd $(DIR) && \
	 sed -i 's@/usr/include@$(WD)/include@g' configure && \
	 ./configure && make -j3 -C lib && make -j3 -C mount mount umount && \
	 make -j3 -C text-utils more && cp mount/{,u}mount text-utils/more $(WD)/bin ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
