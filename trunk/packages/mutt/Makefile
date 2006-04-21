# mutt Makefile

NM= mutt
VRS= 1.5.11
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/mutt/$(FILE)
SHA-$(FILE)= cc5823016fe7de6ee3a131b19a3f78796f9f53d5

PATCH1= patch-$(VRS).vvv.nntp.gz
URL-$(PATCH1)= http://mutt.org.ua/download/mutt-$(VRS)/$(PATCH1)
SHA-$(PATCH1)= 17070778844a6d1b8b668cadf29f4729aea7df69

PATCH50= patch-$(VRS).mutt-j.multi-charset.1.gz
URL-$(PATCH50)= http://www.emaillab.org/mutt/$(VRS)/$(PATCH50)
SHA-$(PATCH50)= f9b44e1168ac669b7c14622056230f648df1686b

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
