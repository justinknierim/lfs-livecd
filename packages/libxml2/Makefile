# LibXML2 Makefile

NM= libxml2
VRS= 2.6.27
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnome.org/pub/GNOME/sources/libxml2/2.6/$(FILE)
SHA-$(FILE)= 8a68083c9b2487a8ce7057629140b857ca2abf74

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's/@TAR@/& --wildcards/' xstc/Makefile.in
	./configure --prefix=/usr --with-history
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
