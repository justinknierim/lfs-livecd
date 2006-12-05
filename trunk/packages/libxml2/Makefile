# LibXML2 Makefile

NM= libxml2
VRS= 2.6.26
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnome.org/pub/GNOME/sources/libxml2/2.6/$(FILE)
SHA-$(FILE)= 7a3e175253d47c924e285e3b8e344ba59b5f1797

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
