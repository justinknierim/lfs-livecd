# Grub Makefile

NM= grub
VRS= 0.97
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 2580626c4579bd99336d3af4482c346c95dac4fb

PATCH1= $(DIR)-disk_geometry-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 651801fe6d851c9f59ccd16b6bd49f1358c9594c

PATCH2= $(DIR)-256byte_inode-1.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= d9313b5c3b356241b387b394a62723c100743a89

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)

compile-stage2:
	echo "GRUB downloaded."
ifeq ($(CD_ARCH),i686)
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	./configure --prefix=/usr
	make
	make install
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
