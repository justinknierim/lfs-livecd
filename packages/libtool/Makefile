# Libtool Makefile

NM= libtool
VRS= 1.5.22
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 1aeec8e1f9667fa971ba21608d398d278577dd03

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
ifndef CROSS
	./configure --prefix=/usr
else
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr \
	 --libdir=/usr/lib64
endif
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
