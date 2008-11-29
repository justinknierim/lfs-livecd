# Zlib Makefile

NM= zlib
VRS= 1.2.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 967e280f284d02284b0cd8872a8e2e04bfdc7283

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
	./configure --prefix=/usr --shared --libdir=/lib
	make
	make install
	rm -v /lib/libz.so
	ln -sfv ../../lib/libz.so.$(VRS) /usr/lib/libz.so
	make clean
	./configure --prefix=/usr
	make
	make install
	chmod 644 /usr/lib/libz.a

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
