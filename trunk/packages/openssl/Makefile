# OpenSSL Makefile

NM= openssl
VRS= 0.9.8e
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.openssl.org/source/$(FILE)
SHA-$(FILE)= b429872d2a287714ab37e42296e6a5fbe23d32ff

PATCH1= $(NM)-0.9.8e-fix_manpages-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/blfs/svn/$(PATCH1)
SHA-$(PATCH1)= afb498051e466131ae90dfc678234e8876af88a4

DEPS= $(FILE) $(PATCH1)

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(DEPS)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./config --openssldir=/etc/ssl --prefix=/usr shared
	sed -i 's/mcpu=pentium/march=i486/' Configure
	sed -i 's/mcpu=pentium/march=i486/' Makefile
	make MANDIR=/usr/share/man
	make MANDIR=/usr/share/man install
	cp -r certs /etc/ssl

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
