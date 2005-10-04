# Shadow Makefile

NM= shadow
VRS= 4.0.12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= cf54e6803d35a55ab8ed2df649f07c82d3a75b2c

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --libdir=/lib --enable-shared
	sed -i 's/groups$$(EXEEXT) //' src/Makefile
	sed -i '/groups/d' man/Makefile
	make $(PM)
	make install
	cp etc/{limits,login.access} /etc
	sed -e 's@#MD5_CRYPT_ENAB.no@MD5_CRYPT_ENAB yes@' \
	     -e 's@/var/spool/mail@/var/mail@' \
	     -e 's@MAIL_CHECK_ENAB..yes@MAIL_CHECK_ENAB no@' \
	     etc/login.defs.linux > /etc/login.defs
	mv /usr/bin/passwd /bin
	mv /lib/libshadow.*a /usr/lib
	rm /lib/libshadow.so
	ln -sf ../../lib/libshadow.so.0 /usr/lib/libshadow.so
	mkdir -p /etc/default
	pwconv
	grpconv

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
