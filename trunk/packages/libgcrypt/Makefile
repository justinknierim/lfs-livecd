# libgcrypt Makefile

NM= libgcrypt
VRS= 1.2.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnupg.org/gcrypt/libgcrypt/$(FILE)
SHA-$(FILE)= a9efab77c764a57ac13e11cf89396f945d0da85d

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
