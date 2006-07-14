# LFS-Bootscripts Makefile

NM= lfs-bootscripts
VRS= 20060712
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.linuxfromscratch.org/lfs/downloads/development/$(FILE)
SHA-$(FILE)= 6f24f5bea51b294f91cb375fb71f7a41abf78c07

PATCH1= $(DIR)-livecd-1.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	make install-livecd

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
