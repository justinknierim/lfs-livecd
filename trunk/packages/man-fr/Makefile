# man-fr Makefile

NM= man-fr
VRS= 1.58.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ccb.club.fr/man/$(FILE)
SHA-$(FILE)= 4f3347c6f0ce5d007f865d610a69fcf6b37757a8

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	cp -r man? /usr/share/man/fr

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
