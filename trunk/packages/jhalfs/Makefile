# jhalfs Makefile

NM= jhalfs
VRS= 0.2
DIR= $(NM)-$(VRS)

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile
	svn co svn://linuxfromscratch.org/ALFS/jhalfs/branches/$(VRS) $(DIR)
	$(std_build)

compile-stage2:
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
