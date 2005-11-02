# Screen Makefile

NM= screen
VRS= 4.0.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 9a96705ad49ca3437e0ae068a3c8db1b55db83ec

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --with-socket-dir=/var/run/screen \
	 --with-sys-screenrc=/etc/screenrc
	sed -i -e "s@/usr/local/etc/screenrc@/etc/screenrc@" {etc,doc}/*
	make $(PM)
	make install
	install -m 644 etc/etcscreenrc /etc/screenrc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
