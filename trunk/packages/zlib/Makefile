# Zlib Makefile

NM= zlib
VRS= 1.2.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 60faeaaf250642db5c0ea36cd6dcc9f99c8f3902

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage1: Makefile $(FILE)
	$(std_build)

stage2: Makefile $(FILE)
	$(std_build)

compile-stage1:
	./configure --prefix=/tools/zlib
	make
	make install

compile-stage2:
	unset CFLAGS ; ./configure --prefix=/usr --shared --libdir=/lib
	unset CFLAGS ; make
	make install
	rm /lib/libz.so
	ln -sf ../../lib/libz.so.$(VRS) /usr/lib/libz.so
	make clean
	unset CFLAGS ; ./configure --prefix=/usr
	unset CFLAGS ; make
	make install
	chmod 644 /usr/lib/libz.a

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
