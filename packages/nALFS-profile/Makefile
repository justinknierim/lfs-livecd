# nALFS profile Makefile

NM= nALFS-profile
VRS= LFS-SVN
DIR= $(NM)-$(VRS)

URL= svn://svn.linuxfromscratch.org/ALFS/profiles/LFS/trunk

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile 
	@$(call echo_message, Building)
	@svn co -q $(URL) $(DIR)
	cd $(DIR) ; sed -i 's@/your/$(DIR)/packages@/sources@g' config/general.ent
	cp -av $(DIR) /root/ >$(DIR)-$@.log 2>&1
	@touch $@	

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
