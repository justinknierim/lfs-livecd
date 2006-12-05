# vbetool Makefile

NM= vbetool
VRS= 0.7
VRS1= 1
DIR= $(NM)-$(VRS)

FILE= $(NM)_$(VRS)-$(VRS1).tar.gz
URL-$(FILE)= http://ftp.debian.org/debian/pool/main/v/$(NM)/$(FILE)
SHA-$(FILE)= 49c86aa6fb877f35a0b336d6aa1d6b204c2cc66f

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	LIBS="-lz" ./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
