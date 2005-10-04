# OpenSSL Makefile

NM= openssl
VRS= 0.9.7g
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/M-P/$(FILE)
SHA-$(FILE)= 21c1f51188bed0de902985f6ed334284082cb90d

PATCH1= $(DIR)-fix_manpages-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH1)
SHA-$(PATCH1)= 723f730aff3c8d493f5e22bcb70734f48cfb41f4

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./config --openssldir=/etc/ssl --prefix=/usr shared
	sed -i 's/mcpu=pentium/mtune=i486/' Configure
	sed -i 's/mcpu=pentium/mtune=i486/' Makefile
	make $(PM) MANDIR=/usr/share/man
	make MANDIR=/usr/share/man install
	cp -r certs /etc/ssl

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
