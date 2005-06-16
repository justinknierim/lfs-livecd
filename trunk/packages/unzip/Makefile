# UnZip Makefile

# Package versions
NM= unzip
VRS= 5.52
DIR= $(NM)-$(VRS)
FILE= $(NM)552.tar.gz
PATCH1= $(DIR)-fix_Makefile-1.patch
PATCH2= $(DIR)-fix_libz-1.patch
PATCH3= $(DIR)-dont_make_noise-1.patch
URL= http://www.mirrorservice.org/sites/ftp.info-zip.org/pub/infozip/src/$(FILE)
URL1= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH1)
URL2= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH2)
URL3= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH3)



#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f $(PATCH1) ] ; then $(WGET) $(URL1) ; fi
	@if [ ! -f $(PATCH2) ] ; then $(WGET) $(URL2) ; fi
	@if [ ! -f $(PATCH3) ] ; then $(WGET) $(URL3) ; fi
	@if [ ! -f /usr/bin/unzip ] ; then unpack $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH1) && \
	 patch -Np1 -i ../$(PATCH2) && \
	 patch -Np1 -i ../$(PATCH3) && \
	 cp unix/Makefile . && \
	 make prefix=/usr LOCAL_UNZIP=-DUSE_UNSHRINK linux && \
	 make prefix=/usr LOCAL_UNZIP=-DUSE_UNSHRINK linux_shlibz && \
	 make prefix=/usr LOCAL_UNZIP=-DUSE_UNSHRINK install && \
	 cp -d libunzip.so* /usr/lib ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
