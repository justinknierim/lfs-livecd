# dhcpcd Makefile

NM= dhcpcd
VRS= 2.0.8
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://download.berlios.de/dhcpcd/dhcpcd-2.0.8.tar.bz2
SHA-$(FILE)= 4aa72d5029409da9c4d3ea172714d32aba65fb97

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	./configure --prefix="" --sysconfdir=/var/lib --mandir=/usr/share/man
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
