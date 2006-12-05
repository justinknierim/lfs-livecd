# SCIM-Input-Pad Makefile

NM= scim-input-pad
VRS= 0.1.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://heanet.dl.sourceforge.net/sourceforge/scim/$(FILE)
SHA-$(FILE)= c8722aaa261cc46bdc49a3586524ed53422b42dc

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
