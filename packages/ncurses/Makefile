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
ifndef CROSS
	./configure --prefix=$(WD) --with-shared --without-debug \
	 --without-ada --enable-overwrite
else
	CC="$${CC} $(64FLAGS)" CXX="$${CXX} $(64FLAGS)" \
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

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
# The non-wide library is for commercial software only => not for the Live CD
ifndef CROSS
	./configure --prefix=/usr --with-shared \
	    --without-debug --enable-widec --without-cxx-binding
else
	CC="gcc $(64FLAGS)" CXX="g++ $(64FLAGS)" \
	    ./configure --prefix=/usr --libdir=/usr/lib64 --with-shared \
	    --without-debug --enable-widec --without-cxx-binding
endif
	# FIXME: still needed?
	make sources
	make $(PM)
	make install
	chmod 755 /usr/$(LIB_MAYBE64)/*.$(VRS)
	mv /usr/$(LIB_MAYBE64)/libncursesw.so.5* /$(LIB_MAYBE64)
	ln -sf ../../$(LIB_MAYBE64)/libncursesw.so.5 /usr/$(LIB_MAYBE64)/libncursesw.so
	for lib in curses ncurses form panel menu ; do \
	  rm -f /usr/$(LIB_MAYBE64)/lib$${lib}.so ; \
	  echo "INPUT(-l$${lib}w)" >/usr/$(LIB_MAYBE64)/lib$${lib}.so ; \
	  ln -sf lib$${lib}w.a /usr/$(LIB_MAYBE64)/lib$${lib}.a ; \
	 done
	rm -f /usr/$(LIB_MAYBE64)/libcursesw.so
	echo "INPUT(-lncursesw)" >/usr/$(LIB_MAYBE64)/libcursesw.so
	ln -sf libncurses.so /usr/$(LIB_MAYBE64)/libcurses.so
	ln -sf libncursesw.a /usr/$(LIB_MAYBE64)/libcursesw.a
	ln -sf libncurses.a /usr/$(LIB_MAYBE64)/libcurses.a

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
