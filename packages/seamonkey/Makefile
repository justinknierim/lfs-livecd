# Firefox Makefile

NM= seamonkey
VRS= 1.0.5
DIR= mozilla

FILE= $(NM)-$(VRS).source.tar.bz2
URL-$(FILE)= http://ftp.mozilla.org/pub/mozilla.org/$(NM)/releases/$(VRS)/$(FILE)
SHA-$(FILE)= 60be0112e369a06958c0295ad2de995ab476cef1

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
ifeq ($(LFS-ARCH),ppc)
	echo "ac_cv_visibility_pragma=no" >> .mozconfig
endif
	make -f client.mk build
	make -f client.mk install
	svn export --force $(ROOT)/root/.mozilla /root/.mozilla
	ln -sf seamonkey /usr/bin/mozilla

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
