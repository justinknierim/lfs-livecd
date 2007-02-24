# device-mapper Makefile

NM= device-mapper
VRS= 1.02.13
DIR= $(NM).$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= http://downloads.planetmirror.com/pub/sourceware/dm/$(FILE)
SHA-$(FILE)= 54ab22fa9ecc307f10c6761f574f663ba080f6e1

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make
	make install
	install -m644 lib/ioctl/libdevmapper.a /usr/lib

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
