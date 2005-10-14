# Man Makefile

NM= man
VRS= 1.6b
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= e4b84ca61565314ef1a29a4c1221b6321dbdc278

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@-is@&R@g' configure
	sed -i 's@MANPATH./usr/man@#&@g' src/man.conf.in
ifndef CROSS
	./configure -confdir=/etc
else
	CC="gcc $(64FLAGS)" ./configure -confdir=/etc
endif
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
