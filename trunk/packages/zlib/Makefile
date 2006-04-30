# Zlib Makefile

NM= zlib
VRS= 1.2.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 60faeaaf250642db5c0ea36cd6dcc9f99c8f3902

include $(CROSSVARS)

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	CC="$${CC} $(64FLAGS)" CFLAGS="${CFLAGS} -fPIC" ./configure --prefix=$(WD) \
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
	$(ARCH_CC) $(ARCH_CFLAGS) ./configure --prefix=/usr --shared --libdir=/$(LIB_MAYBE64)
	make $(PM)
	make install
	rm /$(LIB_MAYBE64)/libz.so
	ln -sf ../../$(LIB_MAYBE64)/libz.so.$(VRS) /usr/$(LIB_MAYBE64)/libz.so
	make clean
	$(ARCH_CC) ./configure --prefix=/usr $(EXTRA_CONF)
	make $(PM)
	make install
	chmod 644 /usr/$(LIB_MAYBE64)/libz.a

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
