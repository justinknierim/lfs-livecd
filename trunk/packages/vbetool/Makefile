# vbetool Makefile

NM= vbetool
VRS= 0.7
VRS1= 1.1
DIR= $(NM)-$(VRS)

FILE= $(NM)_$(VRS)-$(VRS1).tar.gz
URL-$(FILE)= http://ftp.debian.org/debian/pool/main/v/$(NM)/$(FILE)
SHA-$(FILE)= 889b9b61de44b05a247616d5013a79f6d44fc2ab

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
ifeq ($(CD_ARCH),x86)
	./configure --prefix=/usr
endif
ifeq ($(CD_ARCH),x86_64)
	./configure --prefix=/usr --with-x86emu
endif
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
