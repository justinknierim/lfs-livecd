# GCC Makefile

# Package versions
NM= gcc
VRS= 3.4.3
DIR= $(NM)-$(VRS)
FILE1= $(NM)-core-$(VRS).tar.bz2
FILE2= $(NM)-g++-$(VRS).tar.bz2
PATCH1= $(NM)-$(VRS)-no_fixincludes-1.patch
PATCH2= $(NM)-$(VRS)-specs-2.patch
URL= $(FTP)/$(NM)/$(FILE1)
URL1= $(FTP)/$(NM)/$(FILE2)
URL2= $(FTP)/$(NM)/$(PATCH1)
URL3= $(FTP)/$(NM)/$(PATCH2)

# RULES

.PHONY: pass1 pass2 clean

pass1:
	@echo ""
	@echo "=====> Building $(NM) Pass 1"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE1) ] ; then $(WGET) $(URL) && \
	 mv $(FILE1) $(SRC) ; fi
	if [ ! -f $(WD)/bin/$(NM) ] ; then tar xjvf $(SRC)/$(FILE1) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --libexecdir=$(WD)/lib --with-local-prefix=$(WD) \
	 --disable-nls --enable-shared && make -j3 BOOT_LDFLAGS="-static" bootstrap && \
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
	 --enable-shared --enable-threads=posix --enable-__cxa_atexit --enable-languages=c,c++ --disable-libstdcxx-pch && \
	make -j3 && make install ; fi
	@make clean
	@touch .pass2

clean:
	@-rm -rf $(DIR)
	@-rm -rf $(NM)-build
