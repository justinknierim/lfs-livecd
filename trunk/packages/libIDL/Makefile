# LibIDL Makefile

NM= libIDL
VRS= 0.8.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= ftp://ftp.gnome.org/pub/GNOME/sources/$(NM)/0.8/$(FILE)
SHA-$(FILE)= 93f5d1b1553189c11f5dec4cc6f633a85bb66a08

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
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
