# ReiserFS Progs Makefile

NM= reiserfsprogs
VRS= 3.6.20
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= ftp://ftp.namesys.com/pub/reiserfsprogs/$(FILE)
SHA-$(FILE)= 688b26c224769b46400e314c16f4185c55549e70

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sbindir=/sbin
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
