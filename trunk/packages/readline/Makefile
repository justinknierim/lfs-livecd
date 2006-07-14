# Readline Makefile

NM= readline
VRS= 5.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 4b2ee2bc9c6dd1d238c84a58f7e6db173600b850

PATCH1= $(DIR)-fixes-3.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= f58bbd80c7aed462ab7e97e3ac4eae7cd9d1b835

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage2:
	sed -i '/MV.*old/d' Makefile.in
	sed -i '/{OLDSUFF}/c:' support/shlib-install
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --libdir=/lib
	make $(PM) SHLIB_LIBS=-lncurses
	make install
	chmod -v 755 /lib/lib{readline,history}.so*
	rm -v /lib/lib{readline,history}.so
	ln -sfv ../../lib/libreadline.so.5 /usr/lib/libreadline.so
	ln -sfv ../../lib/libhistory.so.5 /usr/lib/libhistory.so

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
