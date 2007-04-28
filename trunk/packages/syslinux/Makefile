# Syslinux Makefile

NM= syslinux
VRS= 3.36
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/utils/boot/syslinux/$(FILE)
SHA-$(FILE)= 48400dfe91b5ae34f09e085019fd34d21b7bc76c

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	cp -v isolinux.bin /boot/isolinux
	cp -v $(ROOT)/isolinux/{isolinux.cfg,*.msg,splash.lss} /boot/isolinux

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
