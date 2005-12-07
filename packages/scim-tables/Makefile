# SCIM-Tables Makefile

NM= scim-tables
VRS= 0.5.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://heanet.dl.sourceforge.net/sourceforge/scim/$(FILE)
SHA-$(FILE)= aab123b59e4047caf7cf65589c2fef907899325f

# Strictly speaking, not needed: Thai is already supported via XKB
FILE1= Thai.png
PATCH1= thai-table.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	cp ../$(FILE1) icons
	patch -Np1 -i ../$(PATCH1)
	autoreconf -i
	./configure --prefix=/usr --sysconfdir=/etc
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
