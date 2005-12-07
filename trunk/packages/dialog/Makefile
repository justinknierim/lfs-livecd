# Dialog Makefile

NM= dialog
VRS= 1.0-20051107
DIR= $(NM)-$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= ftp://invisible-island.net/dialog/$(FILE)
SHA-$(FILE)= d5d80f43c08dcdc44224da8fedd83d77e6943b3f

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --enable-nls \
	    --enable-widec --with-ncursesw
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
