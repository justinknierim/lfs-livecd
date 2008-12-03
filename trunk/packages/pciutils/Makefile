# PCI Utilities Makefile

NM= pciutils
VRS= 2.2.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 4a58d578cd0e0d81b85f8ee592c0c5e1d6ce6cda

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's/null ;/null 2>\&1 ;/' update-pciids.sh
	make PREFIX=/usr
	make PREFIX=/usr install
	install -m 755 -d /usr/include/pci
	install -m 644 lib/*.h /usr/include/pci
	install -m 644 lib/libpci.a /usr/lib
	update-pciids

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
