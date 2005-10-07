# Util-Linux Makefile

NM= util-linux
VRS= 2.12r
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 740b7eb5ae1148b2200b2cd34a0a6c4b0db577e4

PATCH1= $(DIR)-cramfs-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 00f5192493b939c2c996df9c1f3f769abfa3fa8c

PATCH31= $(DIR)-gcc4_fixes-1.patch
URL-$(PATCH31)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH31)
SHA-$(PATCH31)= 638972c2f2b09cf20aac60ede91e803a96cea4d9

STAGE1_DEPS = $(FILE)
STAGE2_DEPS = $(FILE) $(PATCH1)

ifeq ($(LFS-ARCH),sparc)
STAGE1_DEPS+= $(PATCH31)
STAGE2_DEPS+= $(PATCH31)
endif

# Targets

include $(ROOT)/scripts/functions

stage1: $(STAGE1_DEPS)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)
ifeq ($(LFS-ARCH),sparc)
	cp $(SRC)/$(PATCH31) $(LFSSRC)
endif

compile-stage1:
	sed -i 's@/usr/include@$(WD)/include@g' configure
ifeq ($(LFS-ARCH),sparc)
	patch -Np1 -i ../$(PATCH31)
endif
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
	sed -i 's@etc/adjtime@var/lib/hwclock/adjtime@g' hwclock/hwclock.c
	mkdir -p /var/lib/hwclock
	patch -Np1 -i ../$(PATCH1)
ifeq ($(LFS-ARCH),sparc)
	patch -Np1 -i ../$(PATCH31)
endif
	./configure
	make $(PM) HAVE_KILL=yes HAVE_SLN=yes
	make HAVE_KILL=yes HAVE_SLN=yes install
	mv /usr/bin/logger /bin

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
