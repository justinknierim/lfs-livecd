# Glibc Makefile

# Package versions
NM= glibc
VRS= 20041011
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
	@if [ ! -f $(WD)/bin/ldd ] ; then tar xjvf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --disable-profile --enable-add-ons --enable-kernel=2.6.0 \
	 --with-binutils=$(WD)/bin --without-gd --without-cvs --with-headers=$(WD)/include --disable-selinux && \
	 PARALLELMFLAGS=-j3 make && if [ ! -d $(WD)/etc ] ; then mkdir $(WD)/etc ; fi && \
	 touch $(WD)/etc/ld.so.conf && make install $ ; fi
	@make clean

clean:
	@-rm -rf $(NM)-build
	@-rm -rf $(DIR)
