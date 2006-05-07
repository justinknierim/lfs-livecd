# LibXML2 Makefile

NM= libxml2
VRS= 2.6.23
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnome.org/pub/GNOME/sources/libxml2/2.6/$(FILE)
SHA-$(FILE)= e0e58856532c49bd16447922ec802c7ac99d497d

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --with-history
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
