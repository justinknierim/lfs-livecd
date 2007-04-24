# libidn Makefile

NM= libidn
VRS= 0.6.11
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://josefsson.org/libidn/releases/$(FILE)
SHA-$(FILE)= 66b58bcd5f9a1c3f0519a2cb356f9416a495c14f

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --libdir=/usr/lib
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
