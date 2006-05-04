# Firefox Makefile

NM= seamonkey
VRS= 1.0.1
DIR= mozilla

FILE= $(NM)-$(VRS).source.tar.bz2
URL-$(FILE)= http://ftp.mozilla.org/pub/mozilla.org/$(NM)/releases/$(VRS)/$(FILE)
SHA-$(FILE)= e8673838903d50247d96ed42daf99c2adbd9f577

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH50)
	$(std_build)

compile-stage2:
	sed 's:@TOPSRCDIR@:$(ROOT)/$(PKG)/$(NM)/mozilla:' ../.mozconfig \
	 > .mozconfig
	make -f client.mk build
	make -f client.mk install
	cp -ra $(ROOT)/root/.mozilla /root
	# ln -sf /usr/lib/mozilla/plugins/libmozsvgdec.{so,a} \
	# /usr/lib/$(NM)-$(VRS)/plugins
	ln -sf seamonkey /usr/bin/mozilla

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
