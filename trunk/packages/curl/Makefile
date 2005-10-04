# Curl Makefile

NM= curl
VRS= 7.14.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 617a5a0134cbc0c3ef4649b8a4020e91bab25fa3

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
	find docs -name "Makefile*" -o -name "*.1" -o -name "*.3" | xargs rm
	install -v -d -m755 /usr/share/doc/$(DIR)
	cp -R docs/* /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
