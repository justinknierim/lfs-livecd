# vte Makefile

NM= vte
VRS= 0.16.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnome.org/pub/GNOME/sources/$(NM)/0.16/$(FILE)
SHA-$(FILE)= 048925c933240cc877cb746a91943688fec3ff60

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i -e 's%\\177:%&kh=\\EOH:@7=\\EOF:%g' termcaps/xterm
	./configure --prefix=/usr --disable-python --libexecdir=/usr/sbin
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
