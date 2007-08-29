# LFS-Bootscripts Makefile

NM= lfs-bootscripts
VRS= 6.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.linuxfromscratch.org/lfs/downloads/6.3/$(FILE)
SHA-$(FILE)= 0177e3b1d43c087b677ba10ddfd4cb2cc7dcd7eb

PATCH1= $(NM)-livecd-1.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	make install-livecd

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
