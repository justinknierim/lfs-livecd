# RP-pppoe Makefile

NM= rp-pppoe
VRS= 3.8
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.roaringpenguin.com/files/download/$(FILE)
SHA-$(FILE)= d9a4346701e580b4a6049a940557b38533f9e8f7

PATCH1= $(NM)-3.6-iproute2-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 834a565662061bb5dec6850b4630260cce560471

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	sed -i s@/usr/bin/logger@/bin/logger@ \
	 scripts/pppoe-{connect,setup,stop}.in
	cd src ; ./configure
	cd src ; make
	cd src ; make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
