# GCC Makefile

# Package versions
NM= gcc
VRS= 3.4.3
DIR= $(NM)-$(VRS)
FILE1= $(NM)-core-$(VRS).tar.bz2
FILE2= $(NM)-g++-$(VRS).tar.bz2
FILE3= $(NM)-testsuite-$(VRS).tar.bz2
PATCH1= $(NM)-$(VRS)-no_fixincludes-1.patch
PATCH2= $(NM)-$(VRS)-specs-2.patch
PATCH3= $(NM)-$(VRS)-linkonce-1.patch
URL= $(FTP)/$(NM)/$(FILE1)
URL1= $(FTP)/$(NM)/$(FILE2)
URL2= $(FTP)/$(NM)/$(PATCH1)
URL3= $(FTP)/$(NM)/$(PATCH2)
URL4= $(FTP)/$(NM)/$(PATCH3)
URL5= $(FTP)/$(NM)/$(FILE3)

# RULES

.PHONY: pass1 pass2 clean chroot stage2

pass1:
	@echo ""
	@echo "=====> Building $(NM) Pass 1"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE1) ] ; then $(WGET) $(URL) && \
	 mv $(FILE1) $(SRC) ; fi
	if [ ! -f $(WD)/bin/$(NM) ] ; then tar xjvf $(SRC)/$(FILE1) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --libexecdir=$(WD)/lib --with-local-prefix=$(WD) \
	 --disable-nls --enable-shared --host=$(CHOST) --target=$(CHOST) && \
	 make -j3 bootstrap && \
	 make install && ln -s gcc $(WD)/bin/cc ; fi
	@make clean

pass2:
	@echo ""
	@echo "=====> Building $(NM) Pass 2"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE1) ] ; then $(WGET) $(URL) && \
	 mv $(FILE1) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(FILE2) ] ; then $(WGET) $(URL1) && \
	 mv $(FILE2) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH1) ] ; then $(WGET) $(URL2) && \
	 mv $(PATCH1) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH2) ] ; then $(WGET) $(URL3) && \
	 mv $(PATCH2) $(SRC) ; fi
	@if [ ! -f .pass2 ] ; then tar xjvf $(SRC)/$(FILE1) && tar xjvf $(SRC)/$(FILE2) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH1) && patch -Np1 -i $(SRC)/$(PATCH2) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --libexecdir=$(WD)/lib --with-local-prefix=$(WD) --enable-clocale=gnu \
	 --enable-shared --enable-threads=posix --enable-__cxa_atexit --enable-languages=c,c++ --disable-libstdcxx-pch \
	 --host=$(CHOST) --target=$(CHOST) && \
	make -j3 && make install ; fi
	@make clean
	@touch .pass2

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-gcc $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE1) ] ; then $(WGET) $(URL) && \
	 mv $(FILE1) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(FILE2) ] ; then $(WGET) $(URL1) && \
	 mv $(FILE2) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH1) ] ; then $(WGET) $(URL2) && \
	 mv $(PATCH1) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH2) ] ; then $(WGET) $(URL3) && \
	 mv $(PATCH2) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH3) ] ; then $(WGET) $(URL4) && \
	 mv $(PATCH3) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(FILE3) ] ; then $(WGET) $(URL5) && \
	 mv $(FILE3) $(SRC) ; fi
	@if [ ! -f /usr/bin/gcc ] ; then tar xjvf $(SRC)/$(FILE1) && tar xjvf $(SRC)/$(FILE2) && \
	 cd $(DIR) && patch -Np1 -i $(SRC)/$(PATCH1) && patch -Np1 -i $(SRC)/$(PATCH3) && \
	 sed -i 's/install_to_$$(INSTALL_DEST) //' libiberty/Makefile.in && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=/usr --libexecdir=/usr/lib --enable-shared --enable-threads=posix \
	 --enable-__cxa_atexit --enable-clocale=gnu --enable-languages=c,c++ --host=$(CHOST) --target=$(CHOST) && \
	 make -j3 && make install && ln -s ../usr/bin/cpp /lib && ln -s gcc /usr/bin/cc ; fi
	@make clean	

clean:
	@-rm -rf $(DIR)
	@-rm -rf $(NM)-build
