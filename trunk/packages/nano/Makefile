# Nano Makefile

NM= nano
VRS= 2.0.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.nano-editor.org/dist/v2.0/$(FILE)
SHA-$(FILE)= 9c5e26893879355e41e417de30e9473439ceaf5d

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --enable-color \
	 --enable-multibuffer --enable-nanorc
	make $(PM)
	make install
	mkdir -p /usr/share/doc/nano/examples
	cp doc/nanorc.sample /usr/share/doc/nano/examples
	cp $(ROOT)/etc/nanorc /etc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
