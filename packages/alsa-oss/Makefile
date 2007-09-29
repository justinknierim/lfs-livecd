# alsa-oss Makefile

NM= alsa-oss
VRS= 1.0.14
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://gd.tuwien.ac.at/opsys/linux/alsa/oss-lib/$(FILE)
SHA-$(FILE)= abae0d89a38fbb78a96be1620502279fa37f756d

PATCH1= $(DIR)-format-1.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
