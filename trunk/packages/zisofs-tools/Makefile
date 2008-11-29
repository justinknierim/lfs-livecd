# zisofs-tools Makefile

NM= zisofs-tools
VRS= 1.0.8
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/utils/fs/zisofs/$(FILE)
SHA-$(FILE)= 9ac33b37dcbe00c6adf51d171156cae87e0b7f22

# Targets

include $(ROOT)/scripts/functions

stage1: Makefile $(FILE)
	$(std_build)

compile-stage1:
	./configure --prefix=$(WD) CFLAGS="-I$(WD)/zlib/include" LDFLAGS="-L$(WD)/zlib/lib"
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage1
