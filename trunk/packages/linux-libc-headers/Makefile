# Linux-libc-headers Makefile

NM= linux-libc-headers
VRS= 2.6.12.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= e72c9b260995b269c9fb9248ed468c18fb01f3fd

PATCH1= $(DIR)-inotify-3.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/6.2/$(PATCH1)
SHA-$(PATCH1)= 724f0340907df408d17650fd2e58448d0a9e1799

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

stage2: $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/$(PATCH1) $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	install -dv /usr/include/asm
	cp -Rv include/$(LLH_ASM)/* /usr/include/asm
	cp -Rv include/linux /usr/include
	chown -Rv root:root /usr/include/{asm,linux}
	find /usr/include/{asm,linux} -type d -exec chmod -v 755 {} \;
	find /usr/include/{asm,linux} -type f -exec chmod -v 644 {} \;

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
