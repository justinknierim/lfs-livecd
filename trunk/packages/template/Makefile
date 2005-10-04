# [package-name] Makefile (This is a template for package Makefiles)

NM= [package-name]
VRS= [version-number]
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2 # Use bz2 files wherever possible, especially for lfs-base
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= [sha1sum of $(FILE)]

PATCH1= $(DIR)-some-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= [sha1sum of $(PATCH1)]

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build) # See the scripts/functions file for functions like this
	cp $(SRC)/$(FILE) $(LFSSRC) # Copy LFS-Base packages to safe location

compile-stage1:
	./configure --prefix=$(WD)
	make $(PM)
	make install

# The following target is for use with packages that must be built in chroot
# and which you want to build one at a time. Mostly for troubleshooting.
# For use with packages built in chroot but before the chroot installation of
# Bash.
# NOTE: You would never call the 'chroot' targets directly, they would be
# referenced by other targets in the root Makefile.
chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

# Below is a variation of the above target. This would be used with packages
# built in chroot after Bash, but before BLFS-type packages.
#chroot:
#	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

# Below is the final variation of the above two. For use with packages built
# in chroot but after the lfs-base is done. BLFS-type packages.
#chroot:
#	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(sep_dir_build) # Simple function to create a separate build directory

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
