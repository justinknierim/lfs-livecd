# BRLTTY Makefile

NM= brltty
VRS= 3.7.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.mielke.cc/brltty/releases/$(FILE)
SHA-$(FILE)= 0aa8a51a03687acddadbd422f5dff688a5a89b97

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i '/linux\/compiler\.h/d' Programs/usb_linux.c
	./configure --prefix=/usr --sysconfdir=/etc --disable-speech-support \
	    --disable-api
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
