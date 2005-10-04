# RP-pppoe Makefile

NM= rp-pppoe
VRS= 3.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/Q-S/$(FILE)
SHA-$(FILE)= 4633964034e9a7819f2dca90068eed62a4d0028d

PATCH1= $(DIR)-iproute2-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/Q-S/$(PATCH1)
SHA-$(PATCH1)= 1b844a93855a52146832328c0109240c8e297b2a

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
	 scripts/adsl-{connect,setup,stop}.in
	cd src ; ./configure
	cd src ; make
	cd src ; make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
