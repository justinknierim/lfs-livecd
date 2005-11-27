# bin86 Makefile

NM= bin86
VRS= 0.16.17
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.cix.co.uk/~mayday/dev86/$(FILE)
SHA-$(FILE)= 656f06b4b26d08412132e338baa25e42d713eeec

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
