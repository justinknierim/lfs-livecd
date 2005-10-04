# SquashFS Makefile

NM= squashfs
VRS= 2.2
DIR= $(NM)$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/squashfs/$(FILE)
SHA-$(FILE)= 086c1e38185d6aaa7b6c490a7eea4c653936d158

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	cd $(NM)-tools ; make
	cd $(NM)-tools ; cp -v mksquashfs $(WD)/bin
	cp linux-2.6.12/squashfs2.2-patch $(ROOT)/$(PKG)/linux

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
