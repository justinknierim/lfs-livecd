# diffutils Makefile

NM= diffutils
VRS= 2.8.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= a4c467c3a6a08cde9f3d94d02067ec26436e7dc5

PATCH50= $(DIR)-i18n-1.patch
URL-$(PATCH50)= $(HTTP)/$(NM)/$(PATCH50)
SHA-$(PATCH50)= 2d88d693ab572f04990a3a28deb5e743e288b9da

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
	./configure --prefix=$(WD)
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH50)
	$(std_build)
	cp $(SRC)/$(PATCH50) $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH50)
	touch man/diff.1
	./configure --prefix=/usr
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
