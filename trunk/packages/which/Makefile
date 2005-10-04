# which Makefile

NM= which
VRS= 2.16
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/W-Z/$(FILE)
SHA-$(FILE)= a390999b1c4769814468ebc5bcb610161455f278

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make $(PM)
	rm -f /usr/bin/which
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
