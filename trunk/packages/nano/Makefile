# Nano Makefile

NM= nano
VRS= 1.3.11
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.nano-editor.org/dist/v1.3/$(FILE)
SHA-$(FILE)= 921c88c272eaa768f33a65fa1eed95df90ba2fb9

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
