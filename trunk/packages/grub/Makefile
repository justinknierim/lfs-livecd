# Grub Makefile

NM= grub
VRS= 0.97
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 51d60ce71a40e6ecf6870b3a96067b7866a2c477

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
ifeq ($(LFS-ARCH),x86)
	./configure --prefix=/usr
	make $(PM)
	make install
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
