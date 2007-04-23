# Anthy Makefile

NM= anthy
VRS= 8819
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://osdn.dl.sourceforge.jp/anthy/25046/$(FILE)
SHA-$(FILE)= 231d98518b55f85865bc7c18d365015999cfd179

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --disable-static
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
