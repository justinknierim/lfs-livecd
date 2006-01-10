# Firefox Makefile

NM= mozilla
VRS= 1.7.12
DIR= mozilla

FILE= $(NM)-$(VRS)-source.tar.bz2
URL-$(FILE)= http://ftp.mozilla.org/pub/mozilla.org/mozilla/releases/$(VRS)/source/$(FILE)
SHA-$(FILE)= d94251b86d36b8d5e3e45d31a67ebe334f1ba267

PATCH1= $(NM)-1.7.11-gcc4-2.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/blfs/svn/$(PATCH1)
SHA-$(PATCH1)= 26a27a4f5e01f51f8665b5e1ba9bdf166bb8193e

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
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH50)
	make -f client.mk build
	make -f client.mk install
	cp -ra $(ROOT)/root/.mozilla /root
	ln -sf /usr/lib/mozilla/plugins/libmozsvgdec.{so,a} \
	 /usr/lib/$(NM)-$(VRS)/plugins

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
