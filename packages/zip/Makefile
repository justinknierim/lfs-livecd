# Zip Makefile

NM= zip
VRS= 2.32
DIR= $(NM)-$(VRS)

FILE= $(NM)232.tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 5bc562bf95d9aee0cb6625e6038898e1f191a4aa

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make -f unix/Makefile generic_gcc
	make prefix=/usr -f unix/Makefile install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
