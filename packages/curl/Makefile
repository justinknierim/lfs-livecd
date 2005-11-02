# Curl Makefile

NM= curl
VRS= 7.15.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 5c4d5b57e180d419a311f5fbbc104aac4d3f3a83

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	 ./configure --prefix=/usr --libdir=/usr/$(LIB_MAYBE64)
	make $(PM)
	make install
	find docs -name "Makefile*" -o -name "*.1" -o -name "*.3" | xargs rm
	install -v -d -m755 /usr/share/doc/$(DIR)
	cp -R docs/* /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
