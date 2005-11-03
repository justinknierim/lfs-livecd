# ReiserFS Progs Makefile

NM= reiserfsprogs
VRS= 3.6.19
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 615b070b05b4330a8ac45a7d3c985c7d34ebde8e

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sbindir=/sbin
	make $(PM)
	make install
	ln -s reiserfsck /sbin/fsck.reiserfs
	ln -s mkreiserfs /sbin/mkfs.reiserfs

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
