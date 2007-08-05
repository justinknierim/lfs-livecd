# Reiser4progs Makefile

NM= reiser4progs
VRS= 1.0.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.namesys.com/pub/reiser4progs/$(FILE)
SHA-$(FILE)= 9acc4f829c5760ee159cb3f507e58478e578990d

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sbindir=/sbin
	make
	make install
	ln -sf mkfs.reiser4 /sbin/mkreiser4fs

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
