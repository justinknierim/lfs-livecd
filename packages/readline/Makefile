# Readline Makefile

NM= readline
VRS= 5.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 18f3412c73068509d5f491b7b4535aeaf9522834

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	sed -i '/MV.*old/d' Makefile.in
	sed -i '/{OLDSUFF}/c:' support/shlib-install
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
