# Shadow Makefile

NM= shadow
VRS= 4.0.14
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 7d8c504ae03421f9a75cfef3b97b9713782a6e91

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
ifndef CROSS
	./configure --libdir=/lib --enable-shared
else
	CC="gcc $(64FLAGS)" ./configure --libdir=/lib64 \
   	 --enable-shared
endif
	sed -i 's/groups$$(EXEEXT) //' src/Makefile
	find man -name Makefile -exec sed -i '/groups/d' {} \;
	sed -i -e 's/ ko//' -e 's/ zh_CN zh_TW//' man/Makefile
	make $(PM)
	make install
	cp etc/{limits,login.access} /etc
	sed -e 's@#MD5_CRYPT_ENAB.no@MD5_CRYPT_ENAB yes@' \
	     -e 's@/var/spool/mail@/var/mail@' \
	     -e 's@MAIL_CHECK_ENAB..yes@MAIL_CHECK_ENAB no@' \
	     etc/login.defs > /etc/login.defs
	mv /usr/bin/passwd /bin
	mv /$(LIB_MAYBE64)/libshadow.*a /usr/$(LIB_MAYBE64)
	rm /$(LIB_MAYBE64)/libshadow.so
	ln -sf ../../$(LIB_MAYBE64)/libshadow.so.0 /usr/$(LIB_MAYBE64)/libshadow.so
	mkdir -p /etc/default
	pwconv
	grpconv

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
