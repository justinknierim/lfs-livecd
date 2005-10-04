# Reiser4progs Makefile

NM= reiser4progs
VRS= 1.0.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.namesys.com/pub/reiser4progs/$(FILE) 
SHA-$(FILE)= c2a173d34a87776da79a13c85b17cd3a14fb3abc

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sbindir=/sbin
	make $(PM)
	make install
	ln -s mkfs.reiser4 /sbin/mkreiser4fs

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
