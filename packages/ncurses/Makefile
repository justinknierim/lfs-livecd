# Ncurses Makefile

NM= ncurses
VRS= 5.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 4d54d8ad0b90fffa2780a0a45edb6fcb027ef18d

PATCH1=$(DIR)-coverity_fixes-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/development/$(PATCH1)
SHA-$(PATCH1)= ad7a49ad6e35e61d975700226279594106842f59

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

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

# The non-wide library is for commercial software only => not for the Live CD
# And nothing on the CD uses the C++ binding
compile-stage2:
	patch -Np1 -i ../$(PATCH1)
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
