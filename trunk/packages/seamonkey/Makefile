# Seamonkey Makefile

NM= seamonkey
VRS= 1.1.9
DIR= mozilla

FILE= $(NM)-$(VRS).source.tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= e33d78a005d01f982e45db55034d776fda419e25

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
	echo "EXTRA_DSO_LDOPTS += \$$(XLDFLAGS) -lX11 -lXrender" >> \
	 layout/build/Makefile.in
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
