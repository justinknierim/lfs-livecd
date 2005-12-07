# tin Makefile

NM= tin
VRS= 1.6.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= ftp://ftp.tin.org/pub/news/clients/$(NM)/v1.6/$(FILE)
SHA-$(FILE)= 9ab37d0b2712c074e60d99d0cf5bb3a774be75db

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --enable-included-msgs \
	 --with-screen=ncursesw --with-mailer=/usr/bin/msmtp \
	 --enable-nntp-only --disable-pgp-gpg --disable-printing
	make $(PM) build
	make install
	cp $(ROOT)/etc/tinrc /etc
	echo -e 'lfs.support:\nblfs.support:\nlivecd:' >/root/.newsrc

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
