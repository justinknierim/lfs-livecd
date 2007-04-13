# Shadow Makefile

NM= shadow
VRS= 4.0.18.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 1a30458e9db05560bfc82529048bd5d60b45cf9b

PATCH1= $(DIR)-useradd_fix-2.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 08618217ae8ce554f7d7171b7a920cb7c31254c0

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --libdir=/lib --sysconfdir=/etc --enable-shared --without-selinux
	sed -i 's/groups$$(EXEEXT) //' src/Makefile
	find man -name Makefile -exec sed -i '/groups/d' {} \;
	sed -i -e 's/ ko//' -e 's/ zh_CN zh_TW//' man/Makefile
	for i in de es fi fr id it pt_BR; do \
	    convert-mans UTF-8 ISO-8859-1 man/$$i/*.? ; \
	done
	
	for i in cs hu pl; do \
	    convert-mans UTF-8 ISO-8859-2 man/$$i/*.? ; \
	done
	
	convert-mans UTF-8 EUC-JP man/ja/*.?
	convert-mans UTF-8 KOI8-R man/ru/*.?
	convert-mans UTF-8 ISO-8859-9 man/tr/*.?
	make
	make install
	cp etc/{limits,login.access} /etc
	sed -e 's@#MD5_CRYPT_ENAB.no@MD5_CRYPT_ENAB yes@' \
	     -e 's@/var/spool/mail@/var/mail@' \
	     -e 's@MAIL_CHECK_ENAB..yes@MAIL_CHECK_ENAB no@' \
	     etc/login.defs > /etc/login.defs
	mv -v /usr/bin/passwd /bin
	mv -v /lib/libshadow.*a /usr/lib
	rm -v /lib/libshadow.so
	ln -sfv ../../lib/libshadow.so.0 /usr/lib/libshadow.so
	mkdir -pv /etc/default
	pwconv
	grpconv
	useradd -D -b /home
	sed -i 's/yes/no/' /etc/default/useradd

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
