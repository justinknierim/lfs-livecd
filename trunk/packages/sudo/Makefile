# sudo Makefile

NM= sudo
VRS= 1.6.8p12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= a8a2bfaf3912717cad30805e2debf58f5f95244b

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --libexecdir=/usr/lib \
	 --enable-noargs-shell --with-ignore-dot --with-all-insults
	make
	env -i PATH=$$PATH make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
