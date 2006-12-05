# Util-Linux Makefile

NM= util-linux
VRS= 2.12r
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 740b7eb5ae1148b2200b2cd34a0a6c4b0db577e4

FILE1=loop-AES-v3.1d.tar.bz2
URL-$(FILE1)= http://loop-aes.sourceforge.net/loop-AES/$(FILE1)
SHA-$(FILE1)= 0be0d2e4e70c79a53b2ac6462659c1e36d2e69e6

PATCH1= $(DIR)-cramfs-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 00f5192493b939c2c996df9c1f3f769abfa3fa8c

PATCH31= $(DIR)-gcc4_fixes-1.patch
URL-$(PATCH31)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH31)
SHA-$(PATCH31)= 638972c2f2b09cf20aac60ede91e803a96cea4d9

STAGE1_DEPS = $(FILE)
STAGE2_DEPS = $(FILE) $(FILE1) $(PATCH1)

# Targets

include $(ROOT)/scripts/functions

stage1: $(STAGE1_DEPS)
	$(std_build)
	for i in $(STAGE1_DEPS) ; do cp $(SRC)/$$i $(LFSSRC) ; done

compile-stage1:
	sed -i 's@/usr/include@$(WD)/include@g' configure
	./configure
	make -C lib
	make -C mount mount umount
	make -C text-utils more
	cp mount/{,u}mount text-utils/more $(WD)/bin

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(STAGE2_DEPS)
	$(std_build)
	cp $(SRC)/$(PATCH1) $(LFSSRC)/

compile-stage2:
	tar jxf ../$(FILE1)
	patch -Np1 -i */util-linux-2.12r.diff
	sed -i 's@etc/adjtime@var/lib/hwclock/adjtime@g' hwclock/hwclock.c
	mkdir -p /var/lib/hwclock
	patch -Np1 -i ../$(PATCH1)
	make $(PM) HAVE_KILL=yes HAVE_SLN=yes
	make HAVE_KILL=yes HAVE_SLN=yes install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
