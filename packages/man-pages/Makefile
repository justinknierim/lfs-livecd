# Man-pages Makefile

NM= man-pages
VRS= 2.60
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/docs/manpages/Archive/$(FILE)
SHA-$(FILE)= 47204e409a52bf4bb9336301fc9178c4ecc6d99e

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
