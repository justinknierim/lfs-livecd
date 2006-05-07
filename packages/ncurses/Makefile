# Ncurses Makefile

NM= ncurses
VRS= 5.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 46414a72e91a62f63a8c9af00f0d65497f5ecc5a

PATCH50= $(DIR)-fixes-1.patch
URL-$(PATCH50)= $(HTTP)/$(NM)/$(PATCH50)
SHA-$(PATCH50)= 617e1de363a6dc2cfcaf5eaafd78cfe01ab34f48

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
	./configure --prefix=$(WD) --with-shared --without-debug \
	 --without-ada --enable-overwrite
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH50)
	$(std_build)
	cp $(SRC)/$(PATCH50) $(LFSSRC)

# The non-wide library is for commercial software only => not for the Live CD
# And nothing on the CD uses the C++ binding
compile-stage2:
	patch -Np1 -i ../$(PATCH50)
	./configure --prefix=/usr --with-shared \
	    --without-debug --enable-widec --without-cxx-binding
	make
	make install
	chmod 755 /usr/lib/*.$(VRS)
	mv /usr/lib/libncursesw.so.5* /lib
	ln -sfv ../../lib/libncursesw.so.5 /usr/lib/libncursesw.so
	for lib in curses ncurses form panel menu ; do \
	  rm -vf /usr/lib/lib$${lib}.so ; \
	  echo "INPUT(-l$${lib}w)" >/usr/lib/lib$${lib}.so ; \
	  ln -svf lib$${lib}w.a /usr/lib/lib$${lib}.a ; \
	 done
	echo "INPUT(-lncursesw)" >/usr/lib/libcursesw.so
	ln -svf libncurses.so /usr/lib/libcurses.so
	ln -svf libncursesw.a /usr/lib/libcursesw.a
	ln -svf libncurses.a /usr/lib/libcurses.a

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
