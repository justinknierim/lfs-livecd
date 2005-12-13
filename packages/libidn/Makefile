# libidn Makefile

NM= libidn
VRS= 0.5.20
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://josefsson.org/libidn/releases/$(FILE)
SHA-$(FILE)= 42b5795bdf58e39d24e57297f383c8a3e54dca64

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --libdir=/usr/$(LIB_MAYBE64)
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
