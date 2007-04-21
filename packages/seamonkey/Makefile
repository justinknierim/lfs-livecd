# Firefox Makefile

NM= seamonkey
VRS= 1.1.1
DIR= mozilla

FILE= $(NM)-$(VRS).source.tar.bz2
URL-$(FILE)= http://ftp.mozilla.org/pub/mozilla.org/$(NM)/releases/$(VRS)/$(FILE)
SHA-$(FILE)= 08a6a66a1e69e112680e8ad2116c54d7ccb54c3b

MFH=/usr/lib/seamonkey-$(VRS)

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
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
