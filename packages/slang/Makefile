# Slang Makefile

NM= slang
VRS= 2.0.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://gd.tuwien.ac.at/editors/davis/slang/v2.0/$(FILE)
SHA-$(FILE)= ac03f76e032973eebef19888606748b335c49cf0

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc
	make
	make elf
	make install-elf
	chmod 755 /usr/lib/libslang.so.2.0.4
	/sbin/ldconfig

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
