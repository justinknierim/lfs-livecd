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

THAI_FILE= thai-console-data_cvs20051001.tar.bz2
URL-$(THAI_FILE)= http://www.linuxfromscratch.org/~alexander/$(THAI_FILE)
SHA-$(THAI_FILE)= 2d5e8f4d6cf488987600d455078fe8f5d4199217

PATCH1= $(DIR)-backspace-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 39e332e42d5145dfc47786dba5eff63cda91d0ba

PATCH30= $(DIR)-sparc_kbdrate-1.patch
URL-$(PATCH30)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH30)
SHA-$(PATCH30)= 3fe2f0e6a311b8a580f09472dae1b1abbbb7ad21

PATCH3= $(DIR)-gcc4_fixes-1.patch
URL-$(PATCH3)= $(HTTP)/$(NM)/$(PATCH3)
SHA-$(PATCH3)= 93ec9885a79ff79088f1533ec52f1a87dae69500

STAGE2-DEPS = $(FILE) $(BELARUSIAN_FILE) $(THAI_FILE) $(PATCH1) $(PATCH3)
ifeq ($(LFS-ARCH),sparc)
STAGE2-DEPS += $(PATCH30)
endif


# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(STAGE2-DEPS)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1),$(PATCH3)} $(LFSSRC)

compile-stage2:
	cd .. ; unpack $(BELARUSIAN_FILE) ; unpack $(THAI_FILE)
	zcat ../bellinux/console/keymaps/by2_win.kmap.gz > data/keymaps/i386/qwerty/by2_win.map
	sed -i -e 's/\(50 = 0x.\)A/\1C/' data/keymaps/i386/qwerty/by2_win.map
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH3)
ifeq ($(LFS-ARCH),sparc)
	patch -Np1 -i ../$(PATCH30)
endif
	./configure
	make $(PM)
	make install
	# Turkish fixup
	cp /usr/share/kbd/consoletrans/cp857_to_uni.trans /usr/share/kbd/unimaps/cp857.uni
	# Thai fonts and keymaps
	gzip ../thai-console-data/consolefonts/*.psf
	install -m644 ../thai-console-data/consolefonts/*.psf.gz /usr/share/kbd/consolefonts
	install -m644 ../thai-console-data/consoletrans/tis620.acm /usr/share/kbd/consoletrans/tis620_to_uni.trans
	for a in ../thai-console-data/keymaps/*.kmap \
	 ../thai-console-data/keymaps/experimental/*.kmap ; do \
	    mv $${a} $${a%kmap}map ; done
	sed -i 's,\+U,U,g' ../thai-console-data/keymaps/experimental/*.map
	gzip ../thai-console-data/keymaps/*.map ../thai-console-data/keymaps/experimental/*.map
	install -m644 ../thai-console-data/keymaps/*.map.gz ../thai-console-data/keymaps/experimental/*uni*.map.gz /usr/share/kbd/keymaps/i386/qwerty

clean:
	-rm -rf $(DIR)
	-rm -rf bellinux
	-rm -rf thai-console-data

.PHONY: clean chroot compile-stage2
