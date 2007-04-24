# iptables Makefile

NM= iptables
VRS= 1.3.7
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.netfilter.org/projects/iptables/files/$(FILE)
SHA-$(FILE)= 2f25e7a81fb3e81f92b0121d9dcd5a536854dc60

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make PREFIX=/usr LIBDIR=/lib BINDIR=/bin
	make PREFIX=/usr LIBDIR=/lib BINDIR=/bin install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
