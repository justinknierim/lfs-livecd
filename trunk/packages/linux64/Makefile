# Linux Kernel Makefile

NM= linux
VRS= 2.6.21.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
SHA-$(FILE)= 22d5885f87f4b63455891e2042fcae96900af57a

PATCH3= tulip-is-not-a-proper-driver-for-dm910x.patch

PATCH50= linux-2.6.20.1-iocharset-2.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM)64 $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH3)
	patch -Np1 -i ../$(PATCH50)
	make mrproper
	cp ../config.x86_64 .config
	PATH=$$PATH:$(WD)/bin make ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu-
	PATH=$$PATH:$(WD)/bin make modules_install ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu-
	rm /lib/modules/*-64bit/{source,build}
	cp -v arch/x86_64/boot/bzImage /boot/isolinux/linux64

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
