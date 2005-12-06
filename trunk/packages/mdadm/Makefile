# mdadm Makefile

NM= mdadm
VRS= 2.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= http://www.cse.unsw.edu.au/~neilb/source/$(NM)/$(FILE)
SHA-$(FILE)= e6934c5e11009d2e0ed37016dfa8de0fa2e5d76b

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
