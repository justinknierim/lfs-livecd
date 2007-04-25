# man-pages-it Makefile

NM= man-pages-it
VRS= 2.43
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.pluto.it/pub/pluto/ildp/man/$(FILE)
SHA-$(FILE)= 005ff973a735cd10d5b9f0fd389cd72526d763d7

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	find . -type d -exec chmod 755 '{}' \;
	find . -type f -exec chmod 644 '{}' \;
	cp -r man? /usr/share/man/it

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
