# fuse Makefile

NM= fuse
VRS= 2.6.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://switch.dl.sourceforge.net/sourceforge/fuse/$(FILE)
SHA-$(FILE)= d6ecda7341008ac157f55cf901309dda10f58faf

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --disable-kernel-module
	make
	make INIT_D_PATH=. install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
