# Ncurses Makefile

NM= ncurses
VRS= 5.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 4d54d8ad0b90fffa2780a0a45edb6fcb027ef18d

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	./configure --prefix=$(WD) --with-shared --without-normal \
	 --without-debug --without-ada --enable-overwrite --without-cxx-binding
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

# The non-wide library is for commercial software only => not for the Live CD
# And nothing on the CD uses the C++ binding
compile-stage2:
	./configure --prefix=/usr --with-shared --without-normal \
	    --without-debug --enable-widec --without-cxx-binding
	make
	make install
	mv /usr/lib/libncursesw.so.5* /lib
	ln -sfv ../../lib/libncursesw.so.5 /usr/lib/libncursesw.so
	for lib in curses ncurses form panel menu ; do \
	  echo "INPUT(-l$${lib}w)" >/usr/lib/lib$${lib}.so ; \
	 done
	echo "INPUT(-lncursesw)" >/usr/lib/libcursesw.so
	ln -svf libncurses.so /usr/lib/libcurses.so

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
