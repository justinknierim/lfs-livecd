# tin Makefile

NM= tin
VRS= 1.8.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://gd.tuwien.ac.at/infosys/newsreaders/tin/v1.8/$(FILE)
SHA-$(FILE)= 59f13c9eeda414c42f61c408cbac6a59efdc4134

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
	make build
	make install
	mkdir -p /etc/tin
	cp $(ROOT)/etc/tin/tinrc /etc/tin
	echo 'gmane.linux.lfs.support:' >/root/.newsrc
	echo 'gmane.linux.lfs.beyond.support:' >>/root/.newsrc


clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
