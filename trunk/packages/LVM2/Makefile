# lvm2 Makefile

NM= LVM2
VRS= 2.02.27
DIR= $(NM).$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= ftp://sources.redhat.com/pub/lvm2/$(FILE)
SHA-$(FILE)= 0deae8047c934a370d8e825675a514c6f413428f

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
