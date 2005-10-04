# Thunderbird Makefile

NM= thunderbird
VRS= 1.0.6
DIR= mozilla

FILE= $(NM)-$(VRS)-source.tar.bz2
URL-$(FILE)= $(HTTPBLFS)/T-V/$(FILE)
SHA-$(FILE)= 3edb2b98ceda5cb4cbd107757b629587f1a57069

PATCH1= $(NM)-$(VRS)-gcc4-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH1)
SHA-$(PATCH1)= d26a28afe3ca418a2b005daf31a561175cb664eb

PATCH2= $(NM)-$(VRS)-fixes-1.patch
URL-$(PATCH2)= http://www.linuxfromscratch.org/blfs/downloads/svn/$(PATCH2)
SHA-$(PATCH2)= 85108557c83d0feafba5e080fdf6247a717237c8

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)

compile-stage2:
	sed 's!@TOPSRCDIR@!$(ROOT)/$(PKG)/$(NM)/mozilla!' \
	 ../.mozconfig > .mozconfig
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	make -f client.mk build
	make -f client.mk install
	cd $(ROOT)/$(PKG)/$(NM)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2

