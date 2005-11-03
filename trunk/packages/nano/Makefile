# Nano Makefile

NM= nano
VRS= 1.2.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= e78d9c3f7795aca3b4e03eb5cea00c4490a4fb44

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
	cp nanorc.sample /usr/share/doc/nano/examples
	cp $(ROOT)/etc/nanorc /etc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
