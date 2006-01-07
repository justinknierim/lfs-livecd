# Man-pages Makefile

NM= man-pages
VRS= 2.18
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 8f3de81d0c5108ca5e3cf6b732fe5176c31a1457

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
