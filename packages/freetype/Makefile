# FreeType Makefile

NM= freetype
VRS= 2.3.4
DIR= $(NM)-$(VRS)
	 
FILE= $(DIR).tar.bz2
URL-$(FILE)= http://download.savannah.gnu.org/releases/freetype/$(FILE)
SHA-$(FILE)= 09b8f5ecbb3e06a14cc1c2f2dc7c04fe34c48eca

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i -r 's:.*(#.*BYTE.*) .*:\1:' include/freetype/config/ftoption.h
	sed -i '/define .*PATENT/s/define/undef/' include/freetype/config/ftoption.h
	./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
