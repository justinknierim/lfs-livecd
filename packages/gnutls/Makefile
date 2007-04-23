# gnutls Makefile

NM= gnutls
VRS= 1.6.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnupg.org/gcrypt/gnutls/$(FILE)
SHA-$(FILE)= d9b0cc20d10d4f0d4f2427a111b0481ae3cbb7da

# There is also version 1.7.8 at http://www.gnu.org/software/gnutls/releases/
# but it is a development version

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
