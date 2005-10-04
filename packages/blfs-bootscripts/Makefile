# BLFS Bootscripts Makefile

NM= blfs-bootscripts
VRS= 20050910
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 9fa8932329962cfa9227ab1c3b5d7aead8866610

PATCH1=$(NM)-add-autosshd-1.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	make install-service-dhcpcd
	make install-service-pppoe
	make install-gpm
	make install-autosshd
	install -m754 blfs/init.d/sshd /etc/rc.d/init.d/ 
	install -m754 blfs/init.d/random /etc/rc.d/init.d/ 
	install -m754 blfs/init.d/portmap /etc/rc.d/init.d/ 
	install -m754 blfs/init.d/nfs-server /etc/rc.d/init.d/ 
	install -m754 blfs/init.d/nfs-client /etc/rc.d/init.d/ 
	install -m754 blfs/init.d/iptables /etc/rc.d/init.d/ 

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
