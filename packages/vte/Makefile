# vte Makefile

NM= vte
VRS= 0.14.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnome.org/pub/GNOME/sources/$(NM)/0.14/$(FILE)
SHA-$(FILE)= 938e6ca0416191c6ac60745a96bfa84c5eb8519e

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
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
