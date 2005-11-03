# OpenSSL Makefile

NM= openssl
VRS= 0.9.7h
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 97f947f60b8da7076109344cfddaad77804708dd

PATCH1= $(DIR)-fix_manpages-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 7640f69ecbe701fd4b71e0d0329d9fffbcc52607

PATCH40= $(DIR)-allow_lib64-1.patch
URL-$(PATCH40)= http://linuxfromscratch.org/~thomasp/x86_64-livecd/$(PATCH40)
SHA-$(PATCH40)= 26ce4198986c9c46b8ae2c85918f831f550cee88

include $(CROSSVARS)

CONFIG ?= ./config
DEPS= $(FILE) $(PATCHES)

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(DEPS)
	$(std_build)

compile-stage2:
	for PATCH in $(PATCHES) ; do patch -Np1 -i ../$$PATCH ; done
	$(CONFIG) --openssldir=/etc/ssl --prefix=/usr $(SSL_TARGET) shared
ifeq ($(LFS-ARCH),x86)
	sed -i 's/mcpu=pentium/mtune=i486/' Configure
	sed -i 's/mcpu=pentium/mtune=i486/' Makefile
endif
	make $(PM) $(LIBDIR_OVERRIDE) MANDIR=/usr/share/man
	make $(LIBDIR_OVERRIDE) MANDIR=/usr/share/man install
	cp -r certs /etc/ssl

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
