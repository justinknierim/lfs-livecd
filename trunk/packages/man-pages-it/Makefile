# man-pages-it Makefile

NM= man-pages-it
VRS= 2.21
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.pluto.it/pub/pluto/ildp/man/$(FILE)
SHA-$(FILE)= 802cdac169ddc170a3a0ffb6e9e73545f5a80aa7

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

.PHONY: compile-stage1 clean chroot compile-stage2
