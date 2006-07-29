# Syslinux Makefile

NM= syslinux
VRS= 3.11
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/utils/boot/syslinux/$(FILE)
SHA-$(FILE)= d04e012de1e6fed25083d1ba24d3c096493c2b3a

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
