# 915resolution Makefile

NM= 915resolution
VRS= 0.5.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.geocities.com/stomljen/$(FILE)
SHA-$(FILE)= 9f26eb1b728ca0b2d28c948207b034a49b477089

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make clean
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
