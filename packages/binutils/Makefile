# Binutils Makefile

# Package versions
NM= binutils
VRS= 2.15.94.0.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
DLP= $(MKTREE)/$(SRC)/$(FILE)
URL= $(FTP)/$(NM)/$(FILE)
WGET= wget -c --passive-ftp -O $(DLP) $(URL)

#RULES

pre1:
	@su - lfs -c "exec env -i CFLAGS=' $(CFLAGS) ' LFS=$(MP) LC_ALL=POSIX PATH=$(WD)/bin:/bin:/usr/bin \
	 /bin/bash -c 'set +h && umask 022 && cd $(MKTREE) && make lfs-$(NM)-pass1'"

pre2:
	@su - lfs -c "exec env -i CFLAGS=' $(CFLAGS) ' LFS=$(MP) LC_ALL=POSIX PATH=$(WD)/bin:/bin:/usr/bin \
	 /bin/bash -c 'set +h && umask 022 && cd $(MKTREE) && make lfs-$(NM)-pass2'"

pre-adjust:
	@su - lfs -c "exec env -i CFLAGS=' $(CFLAGS) ' LFS=$(MP) LC_ALL=POSIX PATH=$(WD)/bin:/bin:/usr/bin \
	 /bin/bash -c 'set +h && umask 022 && cd $(MKTREE) && make lfs-adjust-toolchain'"
pass1:
	@echo ""
	@echo "=====> Building $(NM) Pass 1"
	@echo ""
	@if [ ! -f $(DLP) ] ; then $(WGET) ; fi
	if [ ! -f $(WD)/bin/ld ] ; then tar xjvf $(DLP) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --disable-nls && make configure-host && make -j3 LDFLAGS="-all-static" && \
	make install && make -C ld clean && make -j3 -C ld LDFLAGS="-all-static" LIB_PATH=/tools/lib ; fi

adjust-toolchain:
	@echo 'main(){}' > dummy.c && cc dummy.c && readelf -l a.out > file
	@if ! cat file | grep -q $(WD) ; then cd $(NM)-build && \
	 make -C ld install && SPECFILE=`gcc --print-file specs` && \
	 sed 's@ /lib/ld-linux.so.2@ $(WD)/lib/ld-linux.so.2@g' $$SPECFILE > tempspecfile && \
	 mv -f tempspecfile $$SPECFILE && unset SPECFILE && \
	 rm -f $(WD)/lib/gcc/*/*/include/{pthread.h,bits/sigthread.h} && \
	 echo 'main(){}' > dummy.c && cc dummy.c && readelf -l a.out | grep ': $(WD)' && \
	 rm dummy.c a.out ; fi
	@make clean

pass2:
	@echo ""
	@echo "=====> Building $(NM) Pass 2"
	@echo ""
	@if [ ! -f $(DLP) ] ; then $(WGET) ; fi
	if [ ! -f .pass2 ] ; then tar xjvf $(DLP) && cd $(DIR) && \
	 mkdir ../$(NM)-build && cd ../$(NM)-build && \
	 ../$(DIR)/configure --prefix=$(WD) --enable-shared --with-lib-path=$(WD)/lib && \
	 make -j3 && make install && make -C ld clean && make -C ld LIB_PATH=/usr/lib:/lib ; fi
	@touch .pass2

clean:
	@-rm -rf $(DIR)
	@-rm -rf $(NM)-build
	@-rm -rf dummy.c a.out
