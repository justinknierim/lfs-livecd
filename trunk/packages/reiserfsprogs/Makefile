# ReiserFS Progs Makefile

NM= reiserfsprogs
VRS= 3.6.19
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/Q-S/$(FILE)
SHA-$(FILE)= f0c0f74272e999e707dafb1e157e9daf5703850e

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
