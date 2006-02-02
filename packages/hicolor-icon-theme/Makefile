# hicolor-icon-theme Makefile

NM= hicolor-icon-theme
VRS= 0.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://icon-theme.freedesktop.org/releases/$(FILE)
SHA-$(FILE)= 640e0f3c0d4a7d0cc983944cba626b8f025deb14

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
