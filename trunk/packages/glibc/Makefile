# Glibc Makefile

# Package versions
NM= glibc
VRS= 20041011
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

.PHONY: stage1 chroot stage2 clean

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

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(MKTREE) && make ch-glibc $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f /$(DLP)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) /$(DLP) ; fi
	@if [ ! -f /usr/bin/ldd ] ; then tar xjvf /$(DLP)/$(FILE) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=/usr --disable-profile --enable-add-ons --enable-kernel=2.6.0 \
	 --without-cvs --libexecdir=/usr/lib/glibc && PARALLELMFLAGS=-j3 make && make -k check && \
	 touch /etc/ld.so.conf && make install && make localedata/install-locales && \
	 make -C ../$(DIR)/linuxthreads/man && make -C ../$(DIR)/linuxthreads/man install && \
	 cp /$(MKTREE)/etc/nsswitch.conf /etc && \
	 cp --remove-destination /usr/share/zoneinfo/$(timezone) /etc/localtime && \
	 cp /$(MKTREE)/etc/ld.so.conf /etc/ld.so.conf ; fi
	@make clean

clean:
	@-rm -rf $(NM)-build
	@-rm -rf $(DIR)
