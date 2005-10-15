# Linux-libc-headers Makefile

NM= linux-libc-headers
VRS= 2.6.12.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= e72c9b260995b269c9fb9248ed468c18fb01f3fd

PATCH30= $(DIR)-sparc_biarch-1.patch
URL-$(PATCH30)= $(HTTP)/$(NM)/$(PATCH30)
SHA-$(PATCH30)= 7581a8221f70dbf0ab2b56d7db4eda14bc076aeb

PATCH31= $(DIR)-sparc_conflicts-1.patch
URL-$(PATCH31)= $(HTTP)/$(NM)/$(PATCH31)
SHA-$(PATCH31)= 6243129a647fe9f09bc4a30545365695898a5744

PATCH40= $(DIR)-x86_64_biarch-1.patch
URL-$(PATCH40)= $(HTTP)/$(NM)/$(PATCH40)
SHA-$(PATCH40)= e29083d611803dc0ae77599d06f21f608f775944

STAGE1_DEPS= $(FILE)
STAGE2_DEPS= $(FILE)

# Targets

include $(ROOT)/scripts/functions

ifeq ($(LFS-ARCH),x86_64)
STAGE1_DEPS+= $(PATCH40)
STAGE2_DEPS+= $(PATCH40)
endif

ifeq ($(LFS-ARCH),sparc64)
STAGE1_DEPS+= $(PATCH30) $(PATCH31)
STAGE2_DEPS+= $(PATCH30) $(PATCH31)
endif

stage1: $(STAGE1_DEPS)
	$(std_build)
	for i in $(STAGE1_DEPS) ; do cp $(SRC)/$$i $(LFSSRC) ; done

compile-stage1:
ifeq ($(LFS-ARCH),x86)
	cp -Rv include/asm-i386 $(WD)/include/asm
endif
ifeq ($(LFS-ARCH),ppc)
	cp -Rv include/asm-ppc $(WD)/include/asm
endif
ifeq ($(LFS-ARCH),sparc64)
	patch -Np1 -i ../$(PATCH30)
	patch -Np1 -i ../$(PATCH31)
	install -d $(WD)/include
	cp -Rv include/asm-sparc $(WD)/include
	cp -Rv include/asm-sparc64 $(WD)/include
	cp -Rv include/asm-sparc-biarch $(WD)/include/asm
endif
ifeq ($(LFS-ARCH),x86_64)
	patch -Np1 -i ../$(PATCH40)
	install -d $(WD)/include
	cp -Rv include/asm-i386 $(WD)/include
	cp -Rv include/asm-x86_64 $(WD)/include
	cp -Rv include/asm-x86_64-biarch $(WD)/include/asm
endif
	cp -Rv include/linux $(WD)/include

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(STAGE2_DEPS)
	$(std_build)

compile-stage2:
ifndef CROSS
ifeq ($(LFS-ARCH),x86)
	cp -Rv include/asm-i386 /usr/include/asm
endif
ifeq ($(LFS-ARCH),ppc)
	cp -Rv include/asm-ppc /usr/include/asm
endif
	cp -Rv include/linux /usr/include
	chown -R root:root /usr/include/{asm,linux}
	find /usr/include/{asm,linux} -type d -exec chmod 755 {} \;
	find /usr/include/{asm,linux} -type f -exec chmod 644 {} \;
else
ifeq ($(LFS-ARCH),x86_64)
	patch -Np1 -i ../$(PATCH40)
	cp -Rv include/asm-i386 /usr/include/
	cp -Rv include/asm-x86_64 /usr/include/
	cp -Rv include/asm-x86_64-biarch /usr/include/asm
endif
ifeq ($(LFS-ARCH),sparc64)
	patch -Np1 -i ../$(PATCH30)
	patch -Np1 -i ../$(PATCH31)
	cp -Rv include/asm-sparc /usr/include/
	cp -Rv include/asm-sparc64 /usr/include/
	cp -Rv include/asm-sparc-biarch /usr/include/asm
endif
	cp -Rv include/linux /usr/include
	cp -Rv include/mtd /usr/include
	cp -Rv include/sound /usr/include
	cp -Rv include/scsi /usr/include
	chown -R root:root \
	 /usr/include/{asm*,linux,mtd,sound,scsi}
	find /usr/include/{asm*,linux,mtd,sound,scsi} \
	 -type d -exec chmod 755 {} \;
	find /usr/include/{asm*,linux,mtd,sound,scsi} \
	 -type f -exec chmod 644 {} \;
endif

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
