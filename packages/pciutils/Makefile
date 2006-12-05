# PCI Utilities Makefile

NM= pciutils
VRS= 2.2.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/software/utils/$(NM)/$(FILE)
SHA-$(FILE)= 9b6e66774caea02790fc22546171bd2d8d75a7c4

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make PREFIX=/usr
	make PREFIX=/usr install
	install -m 755 -d /usr/include/pci
	install -m 644 lib/*.h /usr/include/pci
	install -m 644 lib/libpci.a /usr/lib
	update-pciids

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
