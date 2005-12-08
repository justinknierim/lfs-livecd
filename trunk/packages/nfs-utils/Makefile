# NFS Utilities Makefile

NM= nfs-utils
VRS= 1.0.7
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= e216515f90f6ceb681f1527e5483d0ca53f8ac62

PATCH1= $(DIR)-gcc4-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 9ccb151f6270aff4c5346ccc6ba50d5e7577ca65

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --sysconfdir=/etc --disable-nfsv4 \
	 --disable-gss
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
