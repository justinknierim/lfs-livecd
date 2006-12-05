# SCIM-Anthy Makefile

NM= scim-anthy
VRS= 1.2.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://osdn.dl.sourceforge.jp/scim-imengine/21967/$(FILE)
SHA-$(FILE)= 5f1a1a3084d32f660f0b430b24c441bcfe970764

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
