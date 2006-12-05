# vte Makefile

NM= vte
VRS= 0.12.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnome.org/pub/GNOME/sources/$(NM)/0.12/$(FILE)
SHA-$(FILE)= cc76a380dfe23cfc8aba606b146015a6954d67ae

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	sed -i -e 's%\\177:%&kh=\\EOH:@7=\\EOF:%g' termcaps/xterm
	./configure --prefix=/usr --disable-python --libexecdir=/usr/sbin
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
