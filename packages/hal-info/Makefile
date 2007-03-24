# hal information Makefile

NM= hal-info
VRS= 20070304
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://people.freedesktop.org/~david/dist/$(FILE)
SHA-$(FILE)= bd00e9b95f98af7dc3331a8b2fce9de680e6c22e

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
	    --libexecdir=/usr/lib/hal
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
