# jhalfs Makefile

NM= jhalfs
VRS= trunk
DIR= $(NM)

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile
	@$(call echo_message, Building)
	@svn export svn://linuxfromscratch.org/ALFS/jhalfs/trunk/ /root/$(DIR) \
	 >>$(DIR)-$@.log 2>&1
	@touch $@

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
