# alsa-lib Makefile

NM= alsa-lib
VRS= 1.0.13
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)=  http://gd.tuwien.ac.at/opsys/linux/alsa/lib/$(FILE)
SHA-$(FILE)= 82fa9a7fcb43b319524b18451ca86d691a20f4a3

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
	install -v -m644 -D doc/asoundrc.txt \
	  /usr/share/doc/$(DIR)/asoundrc.txt


clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
