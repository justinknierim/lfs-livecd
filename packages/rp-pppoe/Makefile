# RP-pppoe Makefile

NM= rp-pppoe
VRS= 3.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.roaringpenguin.com/penguin/pppoe/$(FILE)
SHA-$(FILE)= dccb8496c3a106aa83e40bd13e28547f91224f8d

PATCH1= $(DIR)-iproute2-1.patch
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
