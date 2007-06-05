# Linux Kernel Makefile

NM= linux
VRS= 2.6.21.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
SHA-$(FILE)= 13e5d58040ea4bf5434a6957ff04df91955b1250

PATCH3= tulip-is-not-a-proper-driver-for-dm910x.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH3)
	mkdir -p /boot/isolinux
	make mrproper
	cp ../config.x86 .config
	make
	make modules_install
	cp -v arch/i386/boot/bzImage /boot/isolinux/linux
	cd .. ; ./debian-style-headers.sh $(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
