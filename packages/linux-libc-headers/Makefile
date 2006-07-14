# Linux-libc-headers Makefile

NM= linux-libc-headers
VRS= 2.6.12.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= e72c9b260995b269c9fb9248ed468c18fb01f3fd

include $(ROOT)/packages/$(NM)/$(ARCHVARS)

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
	install -d $(WD)/include
	cp -Rv include/$(LLH_ASM) $(WD)/include/asm
	cp -Rv include/linux $(WD)/include

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE)
	$(std_build)

compile-stage2:
	install -dv /usr/include/asm
	cp -Rv include/$(LLH_ASM)/* /usr/include/asm
	cp -Rv include/linux /usr/include
	chown -Rv root:root /usr/include/{asm,linux}
	find /usr/include/{asm,linux} -type d -exec chmod -v 755 {} \;
	find /usr/include/{asm,linux} -type f -exec chmod -v 644 {} \;

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
