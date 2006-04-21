# iptables Makefile

NM= iptables
VRS= 1.3.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.netfilter.org/pub/iptables/$(FILE)
SHA-$(FILE)= 6dbeeee13517fa02852960b6f6e51115c7548a09

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
