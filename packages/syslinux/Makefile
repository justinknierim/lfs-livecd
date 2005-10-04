# Syslinux Makefile

NM= syslinux
VRS= 3.07
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.kernel.org/pub/linux/utils/boot/syslinux/$(FILE)
SHA-$(FILE)= cc7e69f9606a3dc7dfbe4f16c7d51f022f44f936

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
ifeq ($(LFS-ARCH),x86)
	cp -v isolinux.bin /boot/isolinux
	cp -v $(ROOT)/isolinux/{isolinux.cfg,*.msg,splash.lss} /boot/isolinux
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
