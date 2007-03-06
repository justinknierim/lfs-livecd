# libdvdcss Makefile

NM= libdvdcss
VRS= 1.2.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://download.videolan.org/pub/libdvdcss/$(VRS)/$(FILE)
SHA-$(FILE)= 6c834633f58521d8ad09775f625cc723e30f2549

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
