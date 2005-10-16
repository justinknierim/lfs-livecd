# OpenSSL Makefile

NM= openssl
VRS= 0.9.7h
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/M-P/$(FILE)
SHA-$(FILE)= 2e59d045c6100cbd966184fd8fe63644e07cb2b3

PATCH1= $(DIR)-fix_manpages-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 7640f69ecbe701fd4b71e0d0329d9fffbcc52607

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
ifneq ($(LFS-ARCH),sparc64)
	./config --openssldir=/etc/ssl --prefix=/usr shared
ifneq ($(LFS-ARCH),ppc)
	sed -i 's/mcpu=pentium/mtune=i486/' Configure
	sed -i 's/mcpu=pentium/mtune=i486/' Makefile
endif
else
	./Configure --openssldir=/etc/ssl --prefix=/usr linux64-sparcv9 shared
endif
	make $(PM) MANDIR=/usr/share/man
	make MANDIR=/usr/share/man install
	cp -r certs /etc/ssl

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
