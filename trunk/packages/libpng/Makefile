# libpng Makefile

NM= libpng
VRS= 1.2.8
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/L/$(FILE)
SHA-$(FILE)= b6d73493eea4095166118b298efecb54a8e3d2f5

PATCH1= $(DIR)-link_to_proper_libs-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/L/$(PATCH1)
SHA-$(PATCH1)= 24e552875bab65ed200e720c4a58dc92d92ba903

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	make prefix=/usr ZLIBINC=/usr/include ZLIBLIB=/usr/lib \
	 -f scripts/makefile.linux
	make prefix=/usr install -f scripts/makefile.linux
	/sbin/ldconfig

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
