# iptables Makefile

NM= iptables
VRS= 1.3.8
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.netfilter.org/projects/iptables/files/$(FILE)
SHA-$(FILE)= 948f361b194e989b39de4cfa3e95dbe634269ed0

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's/name="$node/name="node/' iptables.xslt
	make PREFIX=/usr LIBDIR=/lib BINDIR=/sbin MANDIR=/usr/share/man KERNEL_DIR=/usr
	make PREFIX=/usr LIBDIR=/lib BINDIR=/sbin MANDIR=/usr/share/man KERNEL_DIR=/usr install
	install -v -m644 iptables.xslt /lib/iptables

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
