# Binutils Makefile

# Package versions
NM= binutils
VRS= 2.15.94.0.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

.PHONY: pass1 adjust-toolchain pass2 chroot-re-adjust-toolchain re-adjust-toolchain clean

pass1:
	@echo ""
	@echo "=====> Building $(NM) Pass 1"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/ld ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --disable-nls && make configure-host && make -j3 LDFLAGS="-all-static" && \
	make install && make -C ld clean && make -j3 -C ld LDFLAGS="-all-static" LIB_PATH=/tools/lib ; fi

adjust-toolchain:
	@if [ ! -f .adj1 ] ; then echo 'main(){}' > dummy.c && cc dummy.c && readelf -l a.out > .adj1 ; fi
	@if ! cat .adj1 | grep -q $(WD) ; then cd $(NM)-build && \
	 make -C ld install && SPECFILE=`gcc --print-file specs` && \
	 sed 's@ /lib/ld-linux.so.2@ $(WD)/lib/ld-linux.so.2@g' $$SPECFILE > tempspecfile && \
	 mv -f tempspecfile $$SPECFILE && unset SPECFILE && \
	 rm -f $(WD)/lib/gcc/*/*/include/{pthread.h,bits/sigthread.h} && cd .. && make clean ; fi

pass2:
	@echo ""
	@echo "=====> Building $(NM) Pass 2"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f .pass2 ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --enable-shared --with-lib-path=$(WD)/lib && \
	 make -j3 && make install && make -C ld clean && make -C ld LIB_PATH=/usr/lib:/lib ; fi
	@touch .pass2

chroot-re-adjust-toolchain:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-re-adjust-toolchain $(chbash1)'

re-adjust-toolchain:
	@if [ ! -f .adj2 ] ; then echo 'main(){}' > dummy.c && cc dummy.c && readelf -l a.out > .adj2 ; fi
	@if cat .adj2 | grep -q $(WD) ; then cd $(NM)-build && make -C ld INSTALL=$(WD)/bin/install install && \
	 perl -pi -e 's@ $(WD)/lib/ld-linux.so.2@ /lib/ld-linux.so.2@g;' `gcc --print-file specs` ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-binutils $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /usr/bin/ld ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=/usr --enable-shared && \
	 make -j3 tooldir=/usr && \
	 make tooldir=/usr install && \
	 cp ../$(DIR)/include/libiberty.h /usr/include ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
	@-rm -rf $(NM)-build
	@-rm -rf dummy.c a.out .file
