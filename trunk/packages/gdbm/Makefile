# gdbm Makefile

NM= gdbm
VRS= 1.8.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 1ebe2b2e75f67790fb9bf3bd18ddee7b618cfe41

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
ifndef CROSS
	./configure --prefix=/usr
else
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr --libdir=/usr/lib64
endif
	make $(PM)
	make BINOWN=root BINGRP=root install install-compat

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
