# Groff Makefile

NM= groff
VRS= 1.19.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= b7303af986de7b7c7722c2dbad07844fac6b6343

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) 
	echo "This package is needed only for non-UTF-8 builds"
	cp $(SRC)/$(FILE) $(LFSSRC)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot
