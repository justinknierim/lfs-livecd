# LibXML2 Makefile

NM= libxml2
VRS= 2.6.23
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnome.org/pub/GNOME/sources/libxml2/2.6/$(FILE)
SHA-$(FILE)= 08c38de94964c137fa541c5f6556170e2c4d8a62

include $(CROSSVARS)

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(ARCH_CC) ./configure --prefix=/usr --with-history $(EXTRA_CONF)
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
