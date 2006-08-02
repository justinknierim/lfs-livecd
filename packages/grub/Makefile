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

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage2:
ifeq ($(LFS-ARCH),x86)
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr
	make $(PM)
	make install
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
