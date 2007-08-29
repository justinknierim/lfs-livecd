# Readline Makefile

NM= readline
VRS= 5.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 18f3412c73068509d5f491b7b4535aeaf9522834

PATCH1= $(DIR)-fixes-3.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/6.3/$(PATCH1)
SHA-$(PATCH1)= de765322d083e26685469f84d75de7465a866cfa

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	sed -i '/MV.*old/d' Makefile.in
	sed -i '/{OLDSUFF}/c:' support/shlib-install
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --libdir=/lib
	make SHLIB_LIBS=-lncurses
	make install
	rm -v /lib/lib{readline,history}.so
	ln -sfv ../../lib/libreadline.so.5 /usr/lib/libreadline.so
	ln -sfv ../../lib/libhistory.so.5 /usr/lib/libhistory.so

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
