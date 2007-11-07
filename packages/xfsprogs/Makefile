# XFS Progs Makefile

NM= xfsprogs
VRS= 2.9.3
DIR= $(NM)-$(VRS)

FILE=$(NM)_$(VRS)-1.tar.gz
URL-$(FILE)= http://www.linuxfromscratch.org/~alexander/$(FILE)
SHA-$(FILE)= 79996d24faefa89d46eb678d4c1c08d25d20dec7

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
