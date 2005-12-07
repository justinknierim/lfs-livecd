# Man Makefile

NM= man
VRS= 1.6b
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= e4b84ca61565314ef1a29a4c1221b6321dbdc278

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	echo "This package is needed only for non-UTF-8 builds"
	cp $(SRC)/$(FILE) $(LFSSRC)
	@touch $@

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot
