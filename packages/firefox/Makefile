# Firefox Makefile

NM= firefox
VRS= 1.0.7
DIR= mozilla

FILE= $(NM)-$(VRS)-source.tar.bz2
URL-$(FILE)= http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$(VRS)/source/$(FILE)
SHA-$(FILE)= ac7549f609db8dbea6db33b2ffb3ae546eea64df

PATCH1= $(NM)-$(VRS)-gcc4-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH1)
SHA-$(PATCH1)= c918d248059e4f5f2f60c2f87ed3c2ebe6a91f7f

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	sed 's:@TOPSRCDIR@:$(ROOT)/$(PKG)/$(NM)/mozilla:' ../.mozconfig \
	 > .mozconfig
	sed -i 's|openURL($${_optLast}|&, new-tab|' browser/app/mozilla.in
	sed -i 's@dist_bin"$$moz_libdir"@&\n    run_moz="$$dist_bin/run-mozilla.sh"@' \
	 browser/app/mozilla.in
	patch -Np1 -i ../$(PATCH1)
	make -f client.mk build
	make -f client.mk install
	cp -ra $(ROOT)/root/.mozilla /root
	mkdir -p /usr/lib/$(NM)-$(VRS)/plugins
	ln -sf /usr/lib/mozilla/plugins/libmozsvgdec.{so,a} \
	 /usr/lib/$(NM)-$(VRS)/plugins

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
