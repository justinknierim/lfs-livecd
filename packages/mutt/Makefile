# mutt Makefile

NM= mutt
VRS= 1.5.10
DIR= $(NM)-$(VRS)

FILE= $(DIR)i.tar.gz
URL-$(FILE)= ftp://ftp.mutt.org/mutt/devel/$(FILE)
SHA-$(FILE)= 3f9cbd330b1458a5c317fd29331f425aa36e0877

PATCH1= patch-$(VRS).vvv.nntp.gz
URL-$(PATCH1)= http://mutt.org.ua/download/mutt-$(VRS)/$(PATCH1)
SHA-$(PATCH1)= 9365a4ebeaf0c113568a03283243604b636f5aae

PATCH50= patch-$(VRS).mutt-j.multi-charset.2.gz
URL-$(PATCH50)= http://www.emaillab.org/mutt/$(VRS)/$(PATCH50)
SHA-$(PATCH50)= 0525d426f835458356b97b742e9fcb87a46cd31c

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
	cd m4 ;	make -f Makefile.am.in
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
