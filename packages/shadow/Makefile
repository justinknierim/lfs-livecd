# Shadow Makefile

NM= shadow
VRS= 4.0.13
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 0f605460c7826d7974089faf793ee2a973c9a176

PATCH1= $(DIR)-configure_fix-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= e1bebfb21e574985db2433cbf2606ea13cd6972f

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage2:
ifndef CROSS
	patch -Np1 -i ../$(PATCH1)
	./configure --libdir=/lib --enable-shared
else
	CC="gcc $(64FLAGS)" ./configure --libdir=/lib64 \
   	 --enable-shared
endif
	sed -i 's/groups$$(EXEEXT) //' src/Makefile
	sed -i '/groups/d' man/Makefile
	make $(PM)
	make install
	cp etc/{limits,login.access} /etc
	sed -e 's@#MD5_CRYPT_ENAB.no@MD5_CRYPT_ENAB yes@' \
	     -e 's@/var/spool/mail@/var/mail@' \
	     -e 's@MAIL_CHECK_ENAB..yes@MAIL_CHECK_ENAB no@' \
	     etc/login.defs > /etc/login.defs
	mv /usr/bin/passwd /bin
ifndef CROSS
	mv /lib/libshadow.*a /usr/lib
	rm /lib/libshadow.so
	ln -sf ../../lib/libshadow.so.0 /usr/lib/libshadow.so
else
	mv /lib64/libshadow.*a /usr/lib64
	rm /lib64/libshadow.so
	ln -sf ../../lib64/libshadow.so.0 /usr/lib64/libshadow.so
endif
	mkdir -p /etc/default
	pwconv
	grpconv

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
