# Dialog Makefile

NM= dialog
VRS= 1.0-20050306
DIR= $(NM)-$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= ftp://invisible-island.net/dialog/$(FILE)
SHA-$(FILE)= c99418b18e0dae9d446b6392bc4804b11d600e3a

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --enable-nls
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
