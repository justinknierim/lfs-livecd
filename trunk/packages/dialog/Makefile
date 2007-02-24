# Dialog Makefile

NM= dialog
VRS= 1.0-20060221
DIR= $(NM)-$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= ftp://invisible-island.net/dialog/$(FILE)
SHA-$(FILE)= aa4fccdb574077e8ca25698a2fa94cd544cd240c

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
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
