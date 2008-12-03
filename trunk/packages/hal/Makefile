# hal Makefile

NM= hal
VRS= 0.5.9.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= fc29322a0beba73c2eab3e0a44f9b820a5fbccdd

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
