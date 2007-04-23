# Dialog Makefile

NM= dialog
VRS= 1.1-20070409
DIR= $(NM)-$(VRS)

FILE= $(DIR).tgz
URL-$(FILE)= ftp://invisible-island.net/dialog/$(FILE)
SHA-$(FILE)= 1ef678ccbb9fd8fecc16189985c2f6dbc815fd37

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
