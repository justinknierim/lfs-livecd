# Util-Linux Makefile

# Package versions
NM= util-linux
VRS= 2.12p
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(MP)/$(DLP)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(MP)/$(DLP) ; fi
	@if [ ! -f $(WD)/bin/mount ] ; then tar xjvf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && \
	 sed -i 's@/usr/include@$(WD)/include@g' configure && \
	 ./configure && make -j3 -C lib && make -j3 -C mount mount umount && \
	 make -j3 -C text-utils more && cp mount/{,u}mount text-utils/more $(WD)/bin ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
