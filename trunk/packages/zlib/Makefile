# Zlib Makefile

NM= zlib
VRS= 1.2.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 967e280f284d02284b0cd8872a8e2e04bfdc7283


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
ifndef CROSS
	./configure --prefix=/usr --shared --libdir=/lib
else
	CC="gcc ${BUILD64}" CXX="g++ ${BUILD64}" CFLAGS="${CFLAGS} -fPIC" \
	 ./configure --prefix=/usr --shared --libdir=/lib64
endif
	make $(PM)
	make install
ifndef CROSS
	rm /lib/libz.so
	ln -sf ../../lib/libz.so.$(VRS) /usr/lib/libz.so
else
	rm /lib64/libz.so
	ln -sf ../../lib64/libz.so.$(VRS) /usr/lib64/libz.so
endif
	make clean
ifndef CROSS
	./configure --prefix=/usr
else
	CC="gcc ${BUILD64}" CXX="g++ ${BUILD64}" ./configure \
    	 --prefix=/usr --libdir=/usr/lib64
endif
	make $(PM)
	make install
ifndef CROSS
	chmod 644 /usr/lib/libz.a
else
	chmod 644 /usr/lib64/libz.a
endif

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
