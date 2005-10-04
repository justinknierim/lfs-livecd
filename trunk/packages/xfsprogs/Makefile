# XFS Progs Makefile

NM= xfsprogs
VRS= 2.6.36
DIR= $(NM)-$(VRS)

FILE= $(DIR).src.tar.gz
URL-$(FILE)= http://mirrors.sunsite.dk/xfs/download/cmd_tars/$(FILE)
SHA-$(FILE)= 95f8862f4b8ceadedc517c89a7ba562aeac31e8f

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(DIR)-fix_compile-1.patch
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
