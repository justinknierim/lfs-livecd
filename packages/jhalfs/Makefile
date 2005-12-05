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
	@$(call echo_message, Building)
	@svn co svn://linuxfromscratch.org/ALFS/jhalfs/tags/$(VRS) $(DIR)
	@make CROSSVARS=../$(CROSSVARS) -C $(DIR) -f ../Makefile compile-$@ >>$(DIR)-$@.log 2>&1
	@make clean >>$(DIR)-$@.log 2>&1
	@touch $@

compile-stage2:
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
