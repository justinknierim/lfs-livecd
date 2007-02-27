# FreeType Makefile

NM= freetype
VRS= 2.3.1
DIR= $(NM)-$(VRS)
	 
FILE= $(DIR).tar.bz2
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/freetype/$(FILE)
SHA-$(FILE)= f87c12c67abb5885486a248a1b83232877f074fe

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
