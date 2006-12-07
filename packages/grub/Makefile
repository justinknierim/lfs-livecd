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

PATCH2=$(DIR)-reiser4-20050808.diff
URL-$(PATCH2)= ftp://ftp.namesys.com/pub/reiser4progs/$(PATCH2)
SHA-$(PATCH2)= ffe2628e07a4c0dcf98360b03d9828936ca21d28

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH2)
	# This will fail to add -fno-strict-aliasing to CFLAGS,
	# but this flag is already present on the CD. So ignore the reject.
	patch -Np1 -i ../$(PATCH1) || true
	sed -i 's/AM_INIT_AUTOMAKE/&\nAM_PROG_AS/' configure.ac
	autoreconf --force --install --verbose
	./configure --prefix=/usr
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
