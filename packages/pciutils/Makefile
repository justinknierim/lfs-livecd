# PCI Utilities Makefile

NM= pciutils
VRS= 2.2.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 4157acd035dc78b2a198d242c3975f289771b484

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
