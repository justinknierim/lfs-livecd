# FreeType Makefile

NM= freetype
VRS= 2.3.7
DIR= $(NM)-$(VRS)
	 
FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= f16f849d6e739ce8842008586af36371a32ac064

FILE2= $(NM)-doc-$(VRS).tar.bz2
URL-$(FILE2)= $(HTTPBLFS)/$(NM)/$(FILE2)
SHA-$(FILE2)= 852918fc87dc2a8a8d7fac03ed3ee9750d695bab

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE2)
	$(std_build)

compile-stage2:
	unpack ../$(FILE2) --strip-components=2 -C docs
	sed -i -r -e 's:.*(#.*BYTE.*) .*:\1:' -e 's:.*(#.*SUBPIX.*) .*:\1:' \
	 include/freetype/config/ftoption.h
	./configure --prefix=/usr
	make
	make install
	install -v -m755 -d /usr/share/doc/$(DIR)
	cp -v -R docs/* /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
