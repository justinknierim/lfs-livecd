# which Makefile

NM= which
VRS= 2.20
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 3bcd6d87aa5231917ba7123319eedcae90cfa0fd

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make
	rm -f /usr/bin/which
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
