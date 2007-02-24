# Grub Makefile

NM= grub
VRS= 0.97
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 2580626c4579bd99336d3af4482c346c95dac4fb

PATCH1= $(DIR)-disk_geometry-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/6.2/$(PATCH1)
SHA-$(PATCH1)= 651801fe6d851c9f59ccd16b6bd49f1358c9594c

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	@echo GRUB downloaded

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	CFLAGS="-O1 -fno-strict-aliasing" ./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
