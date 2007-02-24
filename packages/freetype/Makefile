# FreeType Makefile

NM= freetype
VRS= 2.1.10
DIR= $(NM)-$(VRS)
	 
FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= f9e5c52e466c3e41483d5d6d44b4f3135a9c4b16

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i -r 's:.*(#.*BYTE.*) .*:\1:' include/freetype/config/ftoption.h
	CFLAGS="$(CFLAGS) -fno-strict-aliasing" ./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
