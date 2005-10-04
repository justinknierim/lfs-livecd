# Linux-libc-headers Makefile

NM= linux-libc-headers
VRS= 2.6.12.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= e72c9b260995b269c9fb9248ed468c18fb01f3fd

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
ifeq ($(LFS-ARCH),x86)
	cp -Rv include/asm-i386 $(WD)/include/asm
endif
ifeq ($(LFS-ARCH),ppc)
	cp -Rv include/asm-ppc $(WD)/include/asm
endif
ifeq ($(LFS-ARCH),sparc)
	cp -Rv include/asm-sparc $(WD)/include/asm
endif
	cp -Rv include/linux $(WD)/include

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE)
	$(std_build)

compile-stage2:
ifeq ($(LFS-ARCH),x86)
	cp -Rv include/asm-i386 /usr/include/asm
endif
ifeq ($(LFS-ARCH),ppc)
	cp -Rv include/asm-ppc /usr/include/asm
endif
ifeq ($(LFS-ARCH),sparc)
	cp -Rv include/asm-sparc /usr/include/asm
endif
	cp -Rv include/linux /usr/include
	chown -R root:root /usr/include/{asm,linux}
	find /usr/include/{asm,linux} -type d -exec chmod 755 {} \;
	find /usr/include/{asm,linux} -type f -exec chmod 644 {} \;

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
