# hal Makefile

NM= hal
VRS= 0.5.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://people.freedesktop.org/~david/dist/$(FILE)
SHA-$(FILE)= 5832d97bcaf3dabb9aeb919226e3c38d366057ac

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's/device-manager//g' tools/Makefile.in
	PYTHON=false ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
	    --libexecdir=/usr/lib/hal --disable-policy-kit --enable-parted
	make
	make install
	install -v -m755 -d /var/run/hald

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
