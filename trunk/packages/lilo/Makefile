# lilo Makefile

NM= lilo
VRS= 22.7.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).src.tar.gz
URL-$(FILE)= http://home.san.rr.com/johninsd/pub/linux/lilo/$(FILE)
SHA-$(FILE)= d6de449607dfca518ca4e0d5d3be5d7d98eab0e5

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	# We don't set -DATARAID because it doesn't work (DM major is dynamic)
	sed -i 's/-DMDPRAID/& -DDEVMAPPER -DAUTOAUTO/' Makefile
	make ROOT="" all
	make ROOT="" install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
