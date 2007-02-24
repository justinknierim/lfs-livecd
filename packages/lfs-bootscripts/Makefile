# LFS-Bootscripts Makefile

NM= lfs-bootscripts
VRS= 20070203
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.linuxfromscratch.org/lfs/downloads/development/$(FILE)
SHA-$(FILE)= 9bba196f39f0d86980086f469912865c1585acf8

PATCH1= $(DIR)-livecd-1.patch
PATCH2= $(DIR)-functions-1.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	make install-livecd

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
