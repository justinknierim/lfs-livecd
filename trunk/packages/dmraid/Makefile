# dmraid Makefile

NM= dmraid
VRS= 1.0.0.rc10
DIR= $(NM)

FILE= $(NM)-$(VRS).tar.bz2
URL-$(FILE)= http://people.redhat.com/~heinzm/sw/$(NM)/src/$(FILE)
SHA-$(FILE)= 34fae05d2697908f7bcdb6f063d0b127fe0a5c1c

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	cd $(VRS) ; ./configure --prefix=/usr
	# This package doesn't like parallel build
	cd $(VRS) ; make
	cd $(VRS) ; make install

clean:
	-rm -rf $(NM)

.PHONY: clean chroot compile-stage2
