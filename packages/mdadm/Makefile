# mdadm Makefile

NM= mdadm
VRS= 2.5.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= http://www.cse.unsw.edu.au/~neilb/source/$(NM)/$(FILE)
SHA-$(FILE)= 4852d1efa96da56bfbd3f40681c7cb07b56b0dc7

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make DESTDIR=/usr MANDIR=/share/man
	make DESTDIR=/usr MANDIR=/share/man install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
