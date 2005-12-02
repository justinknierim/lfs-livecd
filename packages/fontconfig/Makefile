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
	# UGLY HACK BELOW. Remove when Greek is supported in DejaVu Sans Mono.
	# Needed in order to avoid fallback to (ugly) FreeMono in Terminal.
	sed -i -e '/prefer/,+2s,^\(.*Sans\) Mono\(.*$$\),&\n\1\2,' /etc/fonts/fonts.conf

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2