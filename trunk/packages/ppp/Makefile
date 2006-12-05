# ppp Makefile

NM= ppp
VRS= 2.4.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://samba.org/ftp/ppp/$(FILE)
SHA-$(FILE)= 9b91b0117e0a8bfaf8c4e894af79e0960dd36259

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make $(PM)
	make install
	svn export --force $(ROOT)/etc/ppp /etc/ppp
	chown -R 0:0 /etc/ppp
	chmod 600 /etc/ppp/pap-secrets

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
