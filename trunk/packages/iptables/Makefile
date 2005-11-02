# iptables Makefile

NM= iptables
VRS= 1.3.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 03cd8b6b1b81ed066b2b7ab387374be87cb4270c

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make $(PM) PREFIX=/usr LIBDIR=/lib BINDIR=/bin
	make PREFIX=/usr LIBDIR=/lib BINDIR=/bin install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
