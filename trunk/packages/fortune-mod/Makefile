# fortune-mod Makefile

NM= fortune-mod
VRS= 1.99.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.redellipse.net/code/downloads/$(FILE)
SHA-$(FILE)= 53aa354025094d7c0e544bb1662714815fa63918

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
