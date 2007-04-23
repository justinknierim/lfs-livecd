# cpio Makefile

NM= cpio
VRS= 2.7
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/pub/gnu/cpio/$(FILE)
SHA-$(FILE)= ce1c8ab703d62fc1d30ca59e044ba9f43c3db574

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure CPIO_MT_PROG=mt --prefix=/usr --bindir=/bin \
	 --libexecdir=/tmp --with-rmt=/usr/sbin/rmt
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
