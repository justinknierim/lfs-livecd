# BRLTTY Makefile

NM= brltty
VRS= 3.8
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.mielke.cc/brltty/releases/$(FILE)
SHA-$(FILE)= d6d12254aa9a01fb34d1665027bc894c28e75e79

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	# Do we want this?
	# sed -i 's/usb_object="linux"/usb_object="libusb"/' configure
	./configure --prefix=/usr --sysconfdir=/etc --disable-speech-support \
	    --disable-api
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
