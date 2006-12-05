# device-mapper Makefile

NM= device-mapper
VRS= 1.02.12
DIR= $(NM).$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= ftp://sources.redhat.com/pub/dm/$(FILE)
SHA-$(FILE)= e1188ea7ddc4976e3614000a492e30fb019de2d6

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make $(PM)
	make install
	install -m644 lib/ioctl/libdevmapper.a /usr/lib

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
