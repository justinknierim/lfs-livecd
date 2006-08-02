# ppp Makefile

NM= ppp
VRS= 2.4.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 6ca9c1d55d74cf65cc7238863a30d95c9870af9b

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
