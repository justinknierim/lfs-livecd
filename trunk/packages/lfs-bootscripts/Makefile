# LFS-Bootscripts Makefile

NM= lfs-bootscripts
VRS= 20081031
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 2a26615debe4dad56d6b608c3f57e4560797b118

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
