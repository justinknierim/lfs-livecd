# Zlib Makefile

NM= zlib
VRS= 1.2.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 967e280f284d02284b0cd8872a8e2e04bfdc7283e


# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	CC="${CC} ${BUILD64}" CFLAGS="${CFLAGS} -fPIC" ./configure --prefix=$(WD) \
	 --shared --libdir=$(WD)/lib64
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	./configure --prefix=/usr --shared --libdir=/lib
	make $(PM)
	make install
	rm /lib/libz.so
	ln -sf ../../lib/libz.so.$(VRS) /usr/lib/libz.so
	make clean
	./configure --prefix=/usr
	make $(PM)
	make install
	chmod 644 /usr/lib/libz.a

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
