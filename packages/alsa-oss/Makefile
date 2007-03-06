# alsa-utils Makefile

NM= alsa-oss
VRS= 1.0.12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://gd.tuwien.ac.at/opsys/linux/alsa/oss-lib/$(FILE)
SHA-$(FILE)= 0a6638df3c719c8b9af22d3e51687cf67cad1984

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
