# libxslt Makefile

NM= libxslt
# Don't use 1.1.18 - see http://bugs.debian.org/399010
VRS= 1.1.17
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnome.org/pub/gnome/sources/libxslt/1.1/$(FILE)
SHA-$(FILE)= d9e7c23227664dba7da04f9bbcfbb470f797c6df

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
