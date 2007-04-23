# 915resolution Makefile

NM= 915resolution
VRS= 0.5.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.geocities.com/stomljen/$(FILE)
SHA-$(FILE)= 377a32d33f1987adf372341c8c6664d5673da9b8

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
