# Fontconfig Makefile

NM= fontconfig
VRS= 2.3.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 89e67a477e6313aea7e55654fd5d9abdc1734bdd

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --disable-docs
	make $(PM)
	make install
	sed -i -e 's/Bitstream Vera/DejaVu/' /etc/fonts/fonts.conf
	sed -i -e 's,^\(\t\t\t<family>Kochi.*\)$$,\1\n\t\t\t<family>AR PL New Sung</family>,' /etc/fonts/fonts.conf
	cp $(ROOT)/etc/fonts/local.conf /etc/fonts/local.conf

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
