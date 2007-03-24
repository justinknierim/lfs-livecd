# Linux-headers Makefile

NM= linux
VRS= 2.6.20.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
SHA-$(FILE)= 2a53ce04db3500d55433c9a25b2949eb342589e0

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	make mrproper
	make headers_install
	make headers_check
	cp -av usr/include/* /tools/include

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE)
	$(std_build)

compile-stage2:
	make mrproper
	make headers_check
	make INSTALL_HDR_PATH=/usr headers_install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2