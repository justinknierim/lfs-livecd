# Kbd Makefile

NM= kbd
VRS= 1.12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 65eaae4d98fca3f7ae7dfc9d9cb7c5a432c6475f

BELARUSIAN_FILE= belarusian-0.3.tar.gz
URL-$(BELARUSIAN_FILE)= http://www.mova.org/bellinux/$(BELARUSIAN_FILE)
SHA-$(BELARUSIAN_FILE)= c0026a915fff58cdc3b68bb57de4eec35a220c43

PATCH1= $(DIR)-backspace-1.patch
SHA-$(PATCH1)= 39e332e42d5145dfc47786dba5eff63cda91d0ba

PATCH2= $(DIR)-sparc_kbdrate-1.patch
URL-$(PATCH2)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 3fe2f0e6a311b8a580f09472dae1b1abbbb7ad21

PATCH3= $(DIR)-gcc4_fixes-1.patch
URL-$(PATCH3)= $(HTTP)/$(NM)/$(PATCH3)
SHA-$(PATCH3)= 93ec9885a79ff79088f1533ec52f1a87dae69500

STAGE2-DEPS = $(FILE) $(BELARUSIAN_FILE) $(PATCH1) $(PATCH3)
ifeq ($(LFS-ARCH),sparc)
STAGE2-DEPS += $(PATCH2)
endif

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(STAGE2-DEPS)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH3)} $(LFSSRC)

compile-stage2:
	cd .. ; unpack $(BELARUSIAN_FILE)
	zcat ../bellinux/console/keymaps/by2_win.kmap.gz > data/keymaps/i386/qwerty/by2_win.map
	sed -i -e 's/\(50 = 0x.\)A/\1C/' data/keymaps/i386/qwerty/by2_win.map
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH3)
ifeq ($(LFS-ARCH),sparc)
	patch -Np1 -i ../$(PATCH2)
endif
	./configure
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)
	-rm -rf bellinux

.PHONY: clean chroot compile-stage2
