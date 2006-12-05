# slang Makefile

NM= slang
VRS= 2.0.6
DIR= $(NM)-$(VRS)

FILE= $(NM)-$(VRS).tar.bz2
URL-$(FILE)= http://gd.tuwien.ac.at/editors/davis/slang/v2.0/$(FILE)
SHA-$(FILE)= 56eac43d825e7e6a643b044d393f2020a34fae7b

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc
	make elf
	make install-elf
	chmod -v 755 /usr/lib/libslang.so.$(VRS)

clean:
	-rm -rf $(NM)

.PHONY: clean chroot compile-stage2
