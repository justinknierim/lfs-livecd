# slrn Makefile

NM= slrn
VRS= 0.9.8.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/$(NM)/$(FILE)
SHA-$(FILE)= d8c3755403c9bb19b83123614cda05f94731027f

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --with-slrnpull \
	 --with-mta="/usr/bin/msmtp -t" --enable-spool --with-ssl
	make $(PM)
	make install
	cp $(ROOT)/root/.slrnrc /root/

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
