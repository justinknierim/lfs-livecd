# BRLTTY Makefile

NM= BRLTTY
VRS= 3.7.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.GZ
URL-$(FILE)= http://www.mielke.cc/brltty/releases/$(FILE)
SHA-$(FILE)= 

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --disable-speech-support --disable-api --without-x
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
