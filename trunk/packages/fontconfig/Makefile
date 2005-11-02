# Fontconfig Makefile

NM= fontconfig
VRS= 2.3.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 4d9eb11ab369b58513b053417f6487b949b1b696

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --disable-docs
	make $(PM)
	make install
	sed -i -e 's/Bitstream Vera/DejaVu/' /etc/fonts/fonts.conf

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
