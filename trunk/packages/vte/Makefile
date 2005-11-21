# vte Makefile

NM= vte
VRS= 0.11.15
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnome.org/pub/GNOME/sources/$(NM)/0.11/$(FILE)
SHA-$(FILE)= 89cf28e721317ffe6fd62f4037469c70eeee03f8

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
