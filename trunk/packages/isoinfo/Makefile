# isoinfo Makefile

NM= isoinfo
VRS= 0.03.02
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= ftp://metalab.unc.edu/pub/Linux/utils/disk-management/$(FILE)
SHA-$(FILE)= 64d4ac5b7a2fe2c1d1787fdb3202634343647d11

PATCH1= $(DIR)-fixes-1.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	make CC="klcc -shared" -f Makefile.Linux isoinfo
	install isoinfo /usr/lib/klibc/bin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
