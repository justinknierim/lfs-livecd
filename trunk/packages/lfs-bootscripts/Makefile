# LFS-Bootscripts Makefile

NM= lfs-bootscripts
VRS= 20060712
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= cd3dec92a837f5e6520c91b3d53773bbd37026d0

PATCH1= $(DIR)-livecd-1.patch
PATCH2= $(DIR)-functions-1.patch

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
	patch -Np1 -i ../$(PATCH2)
	make install-livecd

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
