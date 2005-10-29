# Linux-libc-headers Makefile

NM= linux-libc-headers
VRS= 2.6.12.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= e72c9b260995b269c9fb9248ed468c18fb01f3fd

include $(CROSSVARS)

DEPS= $(FILE) $(PATCHES)

# Targets

include $(ROOT)/scripts/functions

stage1: $(DEPS)
	$(std_build)
	for i in $(DEPS) ; do cp $(SRC)/$$i $(LFSSRC) ; done

compile-stage1:
	for PATCH in $(PATCHES) ; do patch -Np1 -i ../$$PATCH ; done
	install -d $(WD)/include
	cp -Rv include/$(LLH_ASM) $(WD)/include/asm
	for ASM in $(LLH_ASMS) ; do cp -Rv include/$$ASM $(WD)/include ; done
	cp -Rv include/linux $(WD)/include

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(DEPS)
	$(std_build)

compile-stage2:
	for PATCH in $(PATCHES) ; do patch -Np1 -i ../$$PATCH ; done
	cp -Rv include/$(LLH_ASM) /usr/include/asm
	for ASM in $(LLH_ASMS) ; do cp -Rv include/$$ASM /usr/include/ ; done
	cp -Rv include/linux /usr/include
	chown -R root:root /usr/include
	find /usr/include -type d -exec chmod 755 {} \;
	find /usr/include -type f -exec chmod 644 {} \;

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
