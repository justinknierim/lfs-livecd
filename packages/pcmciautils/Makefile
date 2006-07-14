# Sysfsutils Makefile

NM= pcmciautils
VRS= 013
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/utils/kernel/pcmcia/$(FILE)
SHA-$(FILE)= 6e0a903232788c8e0405416c7e5c7b34e9d118d4

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's/MODALIAS/ENV{MODALIAS}/g' udev/rules-base
	>udev/rules-modprobe
	make
	make SYMLINK="ln -sf" install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
