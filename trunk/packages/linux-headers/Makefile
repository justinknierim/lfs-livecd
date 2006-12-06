# Linux-headers Makefile

NM= linux
VRS= 2.6.18.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 8a7df3c58179c8a23a36767de2354baa778d3a50

PATCH1= $(DIR)-unifdef-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 7495a2faab177e9e58f7c4af5b306d387be82410

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage1:
	patch -Np1 -i ../$(PATCH1)
	make mrproper
	make headers_install
	make headers_check
	cp -av usr/include/* /tools/include

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	echo 'header-y += unaligned.h' >> include/asm-generic/Kbuild.asm
	make mrproper
	make headers_check
	make INSTALL_HDR_PATH=/usr headers_install
	chown -Rv root:root /usr/include/{asm,linux}
	find /usr/include/{asm,linux} -type d -exec chmod -v 755 {} \;
	find /usr/include/{asm,linux} -type f -exec chmod -v 644 {} \;

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
