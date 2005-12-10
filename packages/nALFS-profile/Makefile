# nALFS profile Makefile

NM= profile
VRS= LFS-SVN
DIR= $(VRS)

FILE= $(NM)-$(DIR).tar.bz2
URL-$(FILE)= http://www.linuxfromscratch.org/alfs/downloads/profiles/lfs/svn/$(FILE)
SHA-$(FILE)= e0163fbf77a0edae737a9a1c20ad40136d00e651

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@/your/$(DIR)/packages@/sources@g' config/general.ent
	# Temporary fix for LFS-6.1 profile
	sed -i 's@/usr/local@/usr@g' runit.sh
	cp -rav . /root/nALFS-profile-$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
