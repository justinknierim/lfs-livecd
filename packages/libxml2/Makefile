# LibXML2 Makefile

NM= libxml2
VRS= 2.6.22
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= ef9f217d10548ea5bfb0a3f84cc9fc58a2218fb2

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
