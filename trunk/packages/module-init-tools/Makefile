# Module-Init-Tools Makefile

NM= module-init-tools
VRS= 3.2.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= b51e8ac170be23a1f2e301a1dddd47a47ec2186a

PATCH1= $(DIR)-modprobe-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 0caecb2078cc47c97e496e2e4717b8b82a52eb01

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/ --enable-zlib
	make
	make install
	echo 'blacklist 8139cp' >/etc/modprobe.conf
	echo 'blacklist eth1394' >>/etc/modprobe.conf
	echo 'blacklist sk98lin' >>/etc/modprobe.conf

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
