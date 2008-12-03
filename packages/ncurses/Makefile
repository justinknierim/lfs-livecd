# Ncurses Makefile

NM= ncurses
VRS= 5.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 4d54d8ad0b90fffa2780a0a45edb6fcb027ef18d

PATCH1=$(DIR)-coverity_fixes-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= ad7a49ad6e35e61d975700226279594106842f59

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	./configure --prefix=$(WD) --with-shared \
	 --without-debug --without-ada --enable-overwrite
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --with-shared --without-debug --enable-widec
	make
	make install
	chmod -v 644 /usr/lib/libncurses++w.a
	mv /usr/lib/libncursesw.so.5* /lib
	ln -sfv ../../lib/libncursesw.so.5 /usr/lib/libncursesw.so
	for lib in curses ncurses form panel menu ; do \
	  rm -vf /usr/lib/lib$${lib}.so ; \
	  echo "INPUT(-l$${lib}w)" >/usr/lib/lib$${lib}.so ; \
	  ln -sfv lib$${lib}w.a /usr/lib/lib$${lib}.a ; \
	done
	ln -sfv libncurses++w.a /usr/lib/libncurses++.a
	rm -vf /usr/lib/libcursesw.so
	echo "INPUT(-lncursesw)" >/usr/lib/libcursesw.so
	ln -svf libncurses.so /usr/lib/libcurses.so
	ln -sfv libncursesw.a /usr/lib/libcursesw.a
	ln -sfv libncurses.a /usr/lib/libcurses.a
	mkdir -v /usr/share/doc/$(DIR)
	cp -v -R doc/* /usr/share/doc/$(DIR)
	# The non-wide library is for commercial software only => not for the Live CD

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
