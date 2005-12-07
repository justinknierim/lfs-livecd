# man-fr Makefile

NM= man-fr
VRS= 1.58
DIR= $(NM)-$(VRS)

FILE= $(DIR).0.tar.bz2
URL-$(FILE)= http://ccb.club.fr/man/$(FILE)
SHA-$(FILE)= e95ac5648dff7fb8855abc7a5c4e59aa1dd81125

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
