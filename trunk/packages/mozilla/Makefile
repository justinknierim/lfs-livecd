# Firefox Makefile

NM= seamonkey
VRS= 1.0
DIR= mozilla

FILE= $(NM)-$(VRS).source.tar.bz2
URL-$(FILE)= http://ftp.mozilla.org/pub/mozilla.org/$(NM)/releases/$(VRS)/$(FILE)
SHA-$(FILE)= f535ff1d2620ac5a76a2d8179c07f82cd53f938f

PATCH50= $(NM)-$(VRS)-locale-1.patch
URL-$(PATCH50)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH50)
SHA-$(PATCH50)= 4c550d86bcd179030cfc51b64393eb663e10f4c4

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
	patch -Np1 -i ../$(PATCH50)
	make -f client.mk build
	make -f client.mk install
	cp -ra $(ROOT)/root/.mozilla /root
	# ln -sf /usr/lib/mozilla/plugins/libmozsvgdec.{so,a} \
	# /usr/lib/$(NM)-$(VRS)/plugins
	ln -sf seamonkey /usr/lib/mozilla

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
