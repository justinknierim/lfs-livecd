# bin86 Makefile

NM= bin86
VRS= 0.16.17
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= ea9a73068a3569a12ffa12ebffe798e51533faca

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
ifneq ($(LFS-ARCH),ppc)
	$(std_build)
endif

compile-stage2:
	make PREFIX=/usr
	make PREFIX=/usr install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
