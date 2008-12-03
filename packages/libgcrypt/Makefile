# libgcrypt Makefile

NM= libgcrypt
VRS= 1.2.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= c72406c69d6ad9fb3fa1e9824b04566cf204093b

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
	make install
	install -v -m644 -D README /usr/share/doc/$(DIR)/README

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
