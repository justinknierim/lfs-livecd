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

PATCH50= $(DIR)-redhat_fixes-1.patch
URL-$(PATCH50)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH50)
SHA-$(PATCH50)= e3840c242c397e3b8a777043de72e56d8cfa7f18

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH50)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1),$(PATCH50)} $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH50)
ifndef CROSS
	./configure --prefix=/usr --libdir=/lib
else
	CC="gcc $(64FLAGS)" CXX="g++ $(64FLAGS)" \
   	 ./configure --prefix=/usr --libdir=/lib64
endif
	make $(PM) SHLIB_XLDFLAGS=-lncurses
	make install
ifndef CROSS
	chmod 755 /lib/lib{readline,history}.so*
	rm /lib/lib{readline,history}.so
	ln -sf ../../lib/libreadline.so.5 /usr/lib/libreadline.so
	ln -sf ../../lib/libhistory.so.5 /usr/lib/libhistory.so
else
	chmod 755 /lib64/lib{readline,history}.so*
	mv /lib64/lib{readline,history}.a /usr/lib64
	rm /lib64/lib{readline,history}.so
	ln -sf ../../lib64/libreadline.so.5 /usr/lib64/libreadline.so
	ln -sf ../../lib64/libhistory.so.5 /usr/lib64/libhistory.so
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
