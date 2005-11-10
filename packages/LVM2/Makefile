# lvm2 Makefile

NM= LVM2
VRS= 2.01.15
DIR= $(NM).$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= ftp://sources.redhat.com/pub/lvm2/$(FILE)
SHA-$(FILE)= 115d2ad69d2b0c280578774442c4f669bfb6cf1e

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

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
