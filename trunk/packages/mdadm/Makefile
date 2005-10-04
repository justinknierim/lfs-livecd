# mdadm Makefile

NM= mdadm
VRS= 2.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= http://www.cse.unsw.edu.au/~neilb/source/$(NM)/$(FILE)
SHA-$(FILE)= 75d25a58e8a4b99e7e3c8b3dc051d17e32f302dc

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make DESTDIR=/usr
	make DESTDIR=/usr install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
