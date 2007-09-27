# alsa-lib Makefile

NM= alsa-lib
VRS= 1.0.14a
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://gd.tuwien.ac.at/opsys/linux/alsa/lib/$(FILE)
SHA-$(FILE)= 0d0e217b778c411220471cd941ae48c4af675e61

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
