# mutt Makefile

NM= mutt
VRS= 1.4.2.1
DIR= $(NM)-$(VRS)

FILE= $(DIR)i.tar.bz2
URL-$(FILE)= $(HTTPBLFS)/M-P/$(FILE)
SHA-$(FILE)= f56b36f8836ee624633858d903d153e9b6e3afad

PATCH1= patch-$(VRS).vvv.nntp.gz
URL-$(PATCH1)= http://mutt.org.ua/download/mutt-$(VRS)/$(PATCH1)
SHA-$(PATCH1)= ac0ddf0831808b01c67ab27b3e3823ecf1ca131b

PATCH2= $(DIR)-gcc4_fixes-1.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	zcat ../$(PATCH1) | patch -Np1
	patch -Np1 -i ../$(PATCH2)
	./configure --prefix=/usr --sysconfdir=/etc --enable-imap \
	 --enable-pop --enable-nntp --with-ssl
	make $(PM)
	make install
	install -m600  $(ROOT)/root/.muttrc /root

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
