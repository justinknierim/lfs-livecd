# strace Makefile

NM= strace
VRS= 4.5.12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/$(NM)/$(FILE)
SHA-$(FILE)= 1f7754e9b992a147f5313bae9125424e5b4b48a6

PATCH1= $(DIR)-quota_fixes-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 93c5f9884e16668833f2e4020d60661375107d24

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
