# Shadow Makefile

NM= shadow
VRS= 4.1.2.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= a007e90d844d25d67a49699d508613ccea54e068

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's/groups$$(EXEEXT) //' src/Makefile.in
	find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;
	sed -i -e 's/ ko//' -e 's/ zh_CN zh_TW//' man/Makefile.in
	for i in de es fi fr id it pt_BR; do \
	    convert-mans UTF-8 ISO-8859-1 man/$$i/*.? ; \
	done	
	for i in cs hu pl; do \
	    convert-mans UTF-8 ISO-8859-2 man/$$i/*.? ; \
	done
	convert-mans UTF-8 EUC-JP man/ja/*.?
	convert-mans UTF-8 KOI8-R man/ru/*.?
	convert-mans UTF-8 ISO-8859-9 man/tr/*.?
	sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD MD5@' \
	 -e 's@/var/spool/mail@/var/mail@' etc/login.defs
	./configure --sysconfdir=/etc
	make
	make install
	mv -v /usr/bin/passwd /bin
	mkdir -pv /etc/default
	pwconv
	grpconv
	useradd -D -b /home
	sed -i 's/yes/no/' /etc/default/useradd

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
