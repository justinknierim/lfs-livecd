# libgpg-error Makefile

NM= libgpg-error
VRS= 1.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnupg.org/gcrypt/libgpg-error/$(FILE)
SHA-$(FILE)= 6e6f701541e1ecf0a8e438b5b3d26ef05f6b1ffb

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
