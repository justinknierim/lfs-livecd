# lvm2 Makefile

NM= LVM2
VRS= 2.02.17
DIR= $(NM).$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= http://downloads.planetmirror.com/pub/sourceware/lvm2/$(FILE)
SHA-$(FILE)= 7f6066a40c41148e5a6ba4e55a3e302529711498

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
