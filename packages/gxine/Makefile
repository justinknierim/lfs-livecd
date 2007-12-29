# gxine Makefile

NM= gxine
VRS= 0.5.11
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://easynews.dl.sourceforge.net/xine/$(FILE)
SHA-$(FILE)= 74d7e46ff55261c36994b60d66e55720cdb9e165

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's/firefox-nspr/seamonkey-nspr/g' configure
	# most mediamarks are obsolete or not playable without binary codecs
	echo '<GXINEMM VERSION="1">' >misc/mediamarks
	echo '</GXINEMM>' >>misc/mediamarks
	LDFLAGS="$$LDFLAGS -Wl,-R,/usr/lib/seamonkey" ./configure \
	    --prefix=/usr --sysconfdir=/etc \
	    --enable-defeat-screensaver-via-xtest \
	    --enable-watchdog \
	    --disable-integration-wizard
	make
	make GXINE_PLUGINPATH=/usr/lib/seamonkey/plugins install
	sed -n -e 's/\\$$/;/' \
	    -e 's/;\\|$$/; gxine "%s"; test=test -n "$$DISPLAY"\\n/g' \
	    -e 's/MimeType=// p' /usr/share/applications/gxine.desktop >/etc/mailcap

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
