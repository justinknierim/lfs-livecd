# cpio Makefile

NM= cpio
VRS= 2.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 4f65821ec10eb2c330a582fbc8112960c9849ecd

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i -e "s/invalid_arg/argmatch_invalid/" src/mt.c
	./configure CPIO_MT_PROG=mt --prefix=/usr --bindir=/bin \
	 --libexecdir=/tmp --with-rmt=/usr/sbin/rmt
	echo "#define HAVE_SETLOCALE 1" >>config.h
	echo "#define HAVE_LSTAT 1" >>config.h
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
