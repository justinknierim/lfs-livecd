# Automake Makefile

NM= automake
VRS= 1.10.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= cd2e0f7054d4edc75cbf87cd8a92962b3b417b74

PATCH= $(DIR)-test_fix-1.patch
URL-$(PATCH) = $(HTTP)/$(NM)/$(PATCH)
SHA-$(PATCH) = 78c9367ef53046e3a12bd09f61e2b76f6da30f76

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH)
	./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.10.1
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
