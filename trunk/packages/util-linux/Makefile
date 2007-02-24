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

PATCH2= $(DIR)-lseek-1.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 5cebb93628a644b9e2b72944bdcb244f0b67374b

STAGE1_DEPS = $(FILE)
STAGE2_DEPS = $(FILE) $(PATCH1) $(PATCH2)

# Targets

include $(ROOT)/scripts/functions

stage1: $(STAGE1_DEPS)
	$(std_build)

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

compile-stage2:
	sed -i 's@etc/adjtime@var/lib/hwclock/adjtime@g' hwclock/hwclock.c
	mkdir -pv /var/lib/hwclock
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	./configure
	make HAVE_KILL=yes HAVE_SLN=yes
	make HAVE_KILL=yes HAVE_SLN=yes install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
