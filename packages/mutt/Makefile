# mutt Makefile

NM= mutt
VRS= 1.5.15
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://mirrors.dotsrc.org/mutt/devel/$(FILE)
SHA-$(FILE)= 1adabf6e07e099bb664c83e3c0100bbbdfec7a9a

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --enable-imap \
	 --enable-pop --with-ssl --enable-hcache
	make
	make install
	install -m600  $(ROOT)/root/.muttrc /root

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
