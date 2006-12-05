# mutt Makefile

NM= mutt
VRS= 1.5.13
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://mirrors.dotsrc.org/mutt/devel/$(FILE)
SHA-$(FILE)= 6d5b88d33e1727bf0342c31f06d55d7a3d2d4e0a

PATCH1= patch-$(VRS).vvv.nntp.gz
URL-$(PATCH1)= http://mutt.org.ua/download/mutt-$(VRS)/$(PATCH1)
SHA-$(PATCH1)= ce67dcc2f59a709553b626ed93c12cf68f7e8551

PATCH50= patch-$(VRS).mutt-j.multi-charset.1.gz
URL-$(PATCH50)= http://www.emaillab.org/mutt/$(VRS)/$(PATCH50)
SHA-$(PATCH50)= e36884d3cb9c88870feb6d7dc598534db59704dd

PATCH51= mutt-$(VRS)-reject-1.patch
# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH50)
	$(std_build)

compile-stage2:
	zcat ../$(PATCH50) | patch -Np1
	# Unfortunately, patches conflict.
	# Apply the NNTP patch and fix rejects then
	( zcat ../$(PATCH1) | patch -Np1 ) || patch -Np1 -i ../$(PATCH51)
	aclocal -I m4
	autoheader
	automake --foreign
	autoconf
	./configure --prefix=/usr --sysconfdir=/etc --enable-imap \
	 --enable-pop --enable-nntp --with-ssl --enable-hcache
	make $(PM)
	make install
	install -m600  $(ROOT)/root/.muttrc /root

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
