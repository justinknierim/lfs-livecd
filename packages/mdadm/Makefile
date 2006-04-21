# mdadm Makefile

NM= mdadm
VRS= 2.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= http://www.cse.unsw.edu.au/~neilb/source/$(NM)/$(FILE)
SHA-$(FILE)= 07b00e2463582e79924b9298c16a40dbcffb8fc0

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
