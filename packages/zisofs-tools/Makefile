# zisofs-tools Makefile

NM= zisofs-tools
VRS= 1.0.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/utils/fs/zisofs/$(FILE)
SHA-$(FILE)= a95dc42c6e03bdce68acdb803861c9957cb0b8de

# Targets

include $(ROOT)/scripts/functions

stage1: Makefile $(FILE)
	$(std_build)

compile-stage1:
	./configure --prefix=/tools CFLAGS="-I/tools/zlib/include" LDFLAGS="-L/tools/zlib/lib"
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage1
