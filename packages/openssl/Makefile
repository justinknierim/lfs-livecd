# OpenSSL Makefile

NM= openssl
VRS= 0.9.8g
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.openssl.org/source/$(FILE)
SHA-$(FILE)= 4e9c5ced466715d18fd924de79bde5c15da80fa1

PATCH1= $(NM)-$(VRS)-fix_manpages-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/blfs/svn/$(PATCH1)
SHA-$(PATCH1)= afb498051e466131ae90dfc678234e8876af88a4

DEPS= $(FILE) $(PATCH1)

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(DEPS)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./config --openssldir=/etc/ssl --prefix=/usr shared
	make MANDIR=/usr/share/man
	make MANDIR=/usr/share/man install
	cp -r certs /etc/ssl
	install -v -d -m755 /usr/share/doc/$(DIR) && \
	cp -v -r doc/{HOWTO,README,*.{txt,html,gif}} \
	 /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
