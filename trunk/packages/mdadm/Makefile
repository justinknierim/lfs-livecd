# mdadm Makefile

NM= mdadm
VRS= 2.6.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= http://www.cse.unsw.edu.au/~neilb/source/$(NM)/$(FILE)
SHA-$(FILE)= c0f523853a9c816986c24c699fa80b2c02336f3d

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
