# Seamonkey Makefile

NM= seamonkey
VRS= 1.1.3
DIR= mozilla

FILE= $(NM)-$(VRS).source.tar.bz2
URL-$(FILE)= http://releases.mozilla.org/pub/mozilla.org/$(NM)/releases/$(VRS)/$(FILE)
SHA-$(FILE)= 3f7136c8b746d8c789e41839e99465ad4baa1ccb

MFH=/usr/lib/seamonkey

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's/-$$(MOZ_APP_VERSION)//' config/autoconf.mk.in
	sed 's:@TOPSRCDIR@:$(ROOT)/$(PKG)/$(NM)/mozilla:' ../.mozconfig \
	 > .mozconfig
	make -f client.mk build
	make -f client.mk install
	svn export --force $(ROOT)/root/.mozilla /root/.mozilla
	ln -sf seamonkey /usr/bin/mozilla
	MOZILLA_FIVE_HOME=$(MFH) LD_LIBRARY_PATH=$(MFH) $(MFH)/regxpcom
	MOZILLA_FIVE_HOME=$(MFH) LD_LIBRARY_PATH=$(MFH) $(MFH)/regchrome
	touch $(MFH)/chrome/user-{skins,locales}.rdf

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
