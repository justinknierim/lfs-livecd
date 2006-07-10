# vbetool Makefile

NM= vbetool
VRS= 0.6
VRS1= 1.1
DIR= $(NM)-$(VRS)

FILE= $(NM)_$(VRS)-$(VRS1).tar.gz
URL-$(FILE)= http://ftp.debian.org/debian/pool/main/v/$(NM)/$(FILE)
SHA-$(FILE)= c291fbc3874b8c711fcba0564eb45ebb2652495f

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
