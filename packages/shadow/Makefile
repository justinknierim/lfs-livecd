# Shadow Makefile

NM= shadow
VRS= 4.0.15
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 0f7cd3366a032091fdffd2f8edf65056bd576cae

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	./configure --libdir=/lib --enable-shared --without-selinux
	sed -i 's/groups$$(EXEEXT) //' src/Makefile
	find man -name Makefile -exec sed -i '/groups/d' {} \;
	sed -i -e 's/ ko//' -e 's/ zh_CN zh_TW//' man/Makefile
	../convert-mans UTF-8 ISO-8859-2 man/cs/*.?
	../convert-mans UTF-8 ISO-8859-1 man/de/*.?
	../convert-mans UTF-8 ISO-8859-1 man/es/*.?
	../convert-mans UTF-8 ISO-8859-1 man/fi/*.?
	../convert-mans UTF-8 ISO-8859-1 man/fr/*.?
	../convert-mans UTF-8 ISO-8859-2 man/hu/*.?
	../convert-mans UTF-8 ISO-8859-1 man/id/*.?
	../convert-mans UTF-8 ISO-8859-1 man/it/*.?
	../convert-mans UTF-8 EUC-JP man/ja/*.?
	# ../convert-mans UTF-8 EUC-KR man/ko/*.?
	../convert-mans UTF-8 ISO-8859-2 man/pl/*.?
	../convert-mans UTF-8 ISO-8859-1 man/pt_BR/*.?
	../convert-mans UTF-8 KOI8-R man/ru/*.?
	../convert-mans UTF-8 ISO-8859-9 man/tr/*.?
	# ../convert-mans UTF-8 GB2312 man/zh_CN/*.?
	# ../convert-mans UTF-8 BIG5 man/zh_TW/*.?
	make $(PM)
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

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
