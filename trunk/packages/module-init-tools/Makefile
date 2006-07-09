# Module-Init-Tools Makefile

NM= module-init-tools
VRS= 3.2.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= b51e8ac170be23a1f2e301a1dddd47a47ec2186a

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) 
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	./configure --prefix=/ --enable-zlib
	make $(PM)
	make install
	echo 'blacklist 8139cp' >/etc/modprobe.conf
	echo 'blacklist eth1394' >>/etc/modprobe.conf
	echo 'blacklist sk98lin' >>/etc/modprobe.conf

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
