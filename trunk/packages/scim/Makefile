# SCIM Makefile

NM= scim
VRS= 1.4.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://heanet.dl.sourceforge.net/sourceforge/$(NM)/$(FILE)
SHA-$(FILE)= e8563cb0e464f3595b16909c3ee47edcb86ce622

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
	# Never use XIM because it maps to SCIM anyway
	gtk-query-immodules-2.0 | sed 's,ko:ja:th:zh,,' >/etc/gtk-2.0/gtk.immodules

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
