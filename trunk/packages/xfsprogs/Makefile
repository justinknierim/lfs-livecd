# XFS Progs Makefile

NM= xfsprogs
VRS= 2.9.7
DIR= $(NM)-$(VRS)

FILE=$(NM)_$(VRS)-1.tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 7cc9d12681597344978705e2c4a5bc54599e400a

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make DEBUG=-DNDEBUG INSTALL_USER=root INSTALL_GROUP=root \
	 LOCAL_CONFIGURE_OPTIONS="--enable-readline=yes"
	make install
	make install-dev
	chmod -v 755 /lib/libhandle.so*
	rm -f /lib/libhandle.{a,la,so}
	ln -svf ../../lib/libhandle.so.1 /usr/lib/libhandle.so

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
