# XFS Progs Makefile

NM= xfsprogs
VRS= 2.8.18
DIR= $(NM)-$(VRS)

FILE=$(NM)_$(VRS)-1.tar.gz
URL-$(FILE)= http://mirrors.sunsite.dk/xfs/download/cmd_tars/$(FILE)
SHA-$(FILE)= 12ed1cbc5784e5df9a8a2a1c7a061ba459647e80

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i '/autoconf/d' Makefile
	unset CFLAGS ; \
	    make DEBUG=-DNDEBUG INSTALL_USER=root INSTALL_GROUP=root \
	    LOCAL_CONFIGURE_OPTIONS="--enable-static --disable-shared --enable-readline=yes" \
	    OPTIMIZER="$(CFLAGS)"
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
