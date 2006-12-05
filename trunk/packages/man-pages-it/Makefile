# man-pages-it Makefile

NM= man-pages-it
VRS= 2.34
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.pluto.it/pub/pluto/ildp/man/$(FILE)
SHA-$(FILE)= 3304734c29de7d12694dfe6147fa78f63189a2aa

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
