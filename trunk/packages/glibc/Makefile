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
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/ldd ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --disable-profile --enable-add-ons --enable-kernel=2.6.0 \
	 --with-binutils=$(WD)/bin --without-gd --without-cvs --with-headers=$(WD)/include --disable-selinux && \
	 PARALLELMFLAGS=-j3 make && if [ ! -d $(WD)/etc ] ; then mkdir $(WD)/etc ; fi && \
	 touch $(WD)/etc/ld.so.conf && make install $ ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-glibc $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /usr/bin/ldd ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=/usr --disable-profile --enable-add-ons --enable-kernel=2.6.0 \
	 --without-cvs --libexecdir=/usr/lib/glibc && PARALLELMFLAGS=-j3 make && \
	 touch /etc/ld.so.conf && make install && make localedata/install-locales && \
	 make -C ../$(DIR)/linuxthreads/man && make -C ../$(DIR)/linuxthreads/man install && \
	 cp $(ROOT)/etc/nsswitch.conf /etc && \
	 cp --remove-destination /usr/share/zoneinfo/$(timezone) /etc/localtime && \
	 cp $(ROOT)/etc/ld.so.conf /etc/ld.so.conf ; fi
	@make clean

clean:
	@-rm -rf $(NM)-build
	@-rm -rf $(DIR)
