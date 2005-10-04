# Readline Makefile

NM= readline
VRS= 5.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 6df316629de417c16a77a444cc456a3ba949951b

PATCH1= $(DIR)-fixes-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 085d0d973d1a39707c26454db1d414957a85e2d0

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --libdir=/lib
	make $(PM) SHLIB_XLDFLAGS=-lncurses
	make install
	chmod 755 /lib/lib{readline,history}.so*
	rm /lib/lib{readline,history}.so
	ln -sf ../../lib/libreadline.so.5 /usr/lib/libreadline.so
	ln -sf ../../lib/libhistory.so.5 /usr/lib/libhistory.so

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
