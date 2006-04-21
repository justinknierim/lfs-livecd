# dhcpcd Makefile

NM= dhcpcd
VRS= 2.0.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://download.berlios.de/dhcpcd/$(FILE)
SHA-$(FILE)= dec7254ce08114f1ced5e3c37bf528f33bf1ea96

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
