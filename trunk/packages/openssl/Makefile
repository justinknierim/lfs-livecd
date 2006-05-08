# OpenSSL Makefile

NM= openssl
VRS= 0.9.7i
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 4c23925744d43272fa19615454da44e01465eb06

PATCH1= $(DIR)-fix_manpages-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 7640f69ecbe701fd4b71e0d0329d9fffbcc52607

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
