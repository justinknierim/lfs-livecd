# NFS Utilities Makefile

NM= nfs-utils
VRS= 1.0.7
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/M-P/$(FILE)
SHA-$(FILE)= dd84793fbfb88098da4242ec70844604652602c4

PATCH1= $(DIR)-gcc4-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 9ccb151f6270aff4c5346ccc6ba50d5e7577ca65

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	groupadd -g 99 nogroup
	useradd -c "Unprivileged Nobody" -d /dev/null -g nogroup -s /bin/false -u 99 nobody
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --sysconfdir=/etc --disable-nfsv4 \
	 --disable-gss
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
