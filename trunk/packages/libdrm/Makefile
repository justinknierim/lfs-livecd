# libdrm Makefile

NM= libdrm
VRS= 2.0.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://dri.freedesktop.org/libdrm/$(FILE)
SHA-$(FILE)= 99ed33bfd0fa41e8db0ad7d226f33f7546063a1a

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

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
