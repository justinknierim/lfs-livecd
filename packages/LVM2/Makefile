# lvm2 Makefile

NM= LVM2
VRS= 2.01.09
DIR= $(NM).$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= ftp://sources.redhat.com/pub/lvm2/$(FILE)
SHA-$(FILE)= 8c0149e7f9bb8a785111b4d279be5a2bf9a44cd9

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
