# Slang Makefile

NM= slang
VRS= 1.4.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/Q-S/$(FILE)
SHA-$(FILE)= 667709eb1bc1b0f68ce36b31204bf8a99d31eefa

PATCH1= $(DIR)-luit-1.patch
SHA-$(PATCH1)= 9d479948e7d6d387840db8b656b41163d96c1347

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr
	make
	make install
	make elf
	make install-elf
	chmod 755 /usr/lib/libslang.so.1.4.9
	/sbin/ldconfig

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
