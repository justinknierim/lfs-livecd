# Ncurses Makefile

NM= ncurses
VRS= 5.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 3283b776e69134aa49147b66619e01d29bc50714

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
ifneq ($(LFS-ARCH),x86_64)
	./configure --prefix=$(WD) --with-shared --without-debug \
	 --without-ada --enable-overwrite
else
	CC="${CC} ${BUILD64}" CXX="${CXX} ${BUILD64}" \
   	 ./configure --prefix=$(WD) --with-shared \
   	 --host=$(LFS_TARGET) --without-debug --without-ada \
   	 --enable-overwrite --with-build-cc=gcc --libdir=$(WD)/lib64
endif
	make sources
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
ifndef CROSS
	./configure --prefix=/usr --with-shared --without-debug --with-gpm
else
	CC="gcc ${BUILD64}" CXX="g++ ${BUILD64}" \
   	 ./configure --prefix=/usr --libdir=/lib64 --with-shared --without-debug
endif
	make sources
	make $(PM)
	make install
ifndef CROSS
	chmod 755 /usr/lib/*.$(VRS)
	chmod 644 /usr/lib/libncurses++.a && mv /usr/lib/libncurses.so.5* /lib
	ln -sf ../../lib/libncurses.so.5 /usr/lib/libncurses.so
	ln -sf libncurses.so /usr/lib/libcurses.so
else
	mv /lib64/lib{panel,menu,form,ncurses,ncurses++}.a /usr/lib64
	rm /lib64/lib{ncurses,menu,panel,form}.so
	ln -sf ../../lib64/libncurses.so.5 /usr/lib64/libncurses.so
	ln -sf ../../lib64/libmenu.so.5 /usr/lib64/libmenu.so
	ln -sf ../../lib64/libpanel.so.5 /usr/lib64/libpanel.so
	ln -sf ../../lib64/libform.so.5 /usr/lib64/libform.so
	chmod 755 /lib64/lib{panel,menu,form,ncurses}.so.$(VRS)
endif

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
