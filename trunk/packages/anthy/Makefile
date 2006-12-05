# Anthy Makefile

NM= anthy
VRS= 7900
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://osdn.dl.sourceforge.jp/anthy/20887/$(FILE)
SHA-$(FILE)= 9b3ae54ebf81e7aedb095f7c4a3b97027557c258

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --disable-static
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
