# Thunderbird Makefile

# Package versions
NM= thunderbird
VRS= 1.0.7
DIR= mozilla

FILE= $(NM)-$(VRS)-source.tar.bz2
URL-$(FILE)= http://ftp.mozilla.org/pub/mozilla.org/$(NM)/releases/$(VRS)/source/$(FILE)
SHA-$(FILE)= a51640d4d15611374d08dbe6cbf87b1072c66c29

PATCH1= $(NM)-1.0.6-gcc4-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH1)
SHA-$(PATCH1)= d26a28afe3ca418a2b005daf31a561175cb664eb

PATCH2= $(NM)-1.0.6-fixes-1.patch
URL-$(PATCH2)= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH2)
SHA-$(PATCH2)= 85108557c83d0feafba5e080fdf6247a717237c8

PATCH3= $(NM)-1.0.6-locale-1.patch
URL-$(PATCH3)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH3)
SHA-$(PATCH3)= c8ac0c5aaf5d98a5b0830ead6eb6e35a109f6b5b

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2) $(PATCH3)
	$(std_build)

compile-stage2:
	sed 's!@TOPSRCDIR@!$(ROOT)/$(PKG)/$(NM)/mozilla!' \
	 ../.mozconfig > .mozconfig
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	patch -Np1 -i ../$(PATCH3)
	make -f client.mk build
	make -f client.mk install
	cd $(ROOT)/$(PKG)/$(NM)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2

