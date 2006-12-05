# Curl Makefile

NM= curl
VRS= 7.15.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://curl.haxx.se/download/$(FILE)
SHA-$(FILE)= b79ee06d1da58c12c23a1b8aeccdb2b74a692cc7

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make
	make install
	find docs -name "Makefile*" -o -name "*.1" -o -name "*.3" | xargs rm
	install -v -d -m755 /usr/share/doc/$(DIR)
	cp -R docs/* /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
