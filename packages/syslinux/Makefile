# Syslinux Makefile

NM= syslinux
VRS= 3.50
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/utils/boot/syslinux/Old/$(FILE)
SHA-$(FILE)= 181d5dd92da1c709ae09a00e991573c7a1a21203

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	mkdir -p /boot/isolinux
	cp -v isolinux.bin /boot/isolinux
	cp -v $(ROOT)/isolinux/{isolinux.cfg,*.msg,splash.lss} /boot/isolinux

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
