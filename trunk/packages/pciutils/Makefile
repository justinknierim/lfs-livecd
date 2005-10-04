# PCI Utilities Makefile

NM= pciutils
VRS= 2.1.11
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/M-P/$(FILE)
SHA-$(FILE)= fa561d97033d8992d2b20c5ca928e6a2ac9ebcfb

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
	update-pciids

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
