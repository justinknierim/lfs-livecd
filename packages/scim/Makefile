# SCIM Makefile

NM= scim
VRS= 1.4.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://heanet.dl.sourceforge.net/sourceforge/$(NM)/$(FILE)
SHA-$(FILE)= 3b8d26ff5a4ebab1ca90928d0363d2d2b0028ccf

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc
	make
	make install
	gtk-query-immodules-2.0 >/etc/gtk-2.0/gtk.immodules

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
