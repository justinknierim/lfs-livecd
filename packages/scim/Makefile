# SCIM Makefile

NM= scim
VRS= 1.4.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://heanet.dl.sourceforge.net/sourceforge/$(NM)/$(FILE)
SHA-$(FILE)= f6d7cb0ca70d9c3430e460bef58e78ba04919137

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
	gtk-query-immodules-2.0 >/etc/gtk-2.0/gtk.immodules

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
