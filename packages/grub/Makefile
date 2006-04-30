# Grub Makefile

NM= grub
VRS= 0.97
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 2580626c4579bd99336d3af4482c346c95dac4fb

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
ifeq ($(LFS-ARCH),x86)
	./configure --prefix=/usr
	make $(PM)
	make install
endif
ifeq ($(LFS-ARCH),x86_64)
	CC="gcc $(32FLAGS)" ./configure --prefix=/usr
	make $(PM)
	make install
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
