# Nano Makefile

NM= nano
VRS= 2.0.7
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 6616c6496e6f21e61df6bb991c0be84eda5c6a0c

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc/nano --enable-color \
	 --enable-multibuffer --enable-nanorc
	make
	make install
	install -v -m644 -D doc/nanorc.sample /etc/nano/nanorc.sample 
	install -v -m755 -d /usr/share/doc/$(DIR)
	install -v -m644 doc/{,man/,texinfo/}*.html /usr/share/doc/$(DIR)
	cp $(ROOT)/etc/nanorc /etc/nano

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
