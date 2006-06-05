# OpenSSL Makefile

NM= openssl
VRS= 0.9.8b
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 99565db630a044fa484d4f91006a31908f262246

PATCH1= $(DIR)-fix_manpages-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 17a3fc451ab132178e2dc696f19dfe58f218cd4a

CONFIG ?= ./config
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
	# FIXME ppc
	$(CONFIG) --openssldir=/etc/ssl --prefix=/usr shared
ifeq ($(LFS-ARCH),x86)
	sed -i 's/mcpu=pentium/march=i486/' Configure
	sed -i 's/mcpu=pentium/march=i486/' Makefile
endif
	make $(PM) MANDIR=/usr/share/man
	make MANDIR=/usr/share/man install
	cp -r certs /etc/ssl

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
