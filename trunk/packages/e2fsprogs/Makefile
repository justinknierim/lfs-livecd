# E2fsprogs Makefile

NM= e2fsprogs
VRS= 1.41.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= d85f05b7bcef1adf8306a789f3ac0325c3c67e8d

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	mkdir -v build
	cd build
	./configure --prefix=$(WD)
	make
	make install-libs
	chmod -v u+w $(WD)/lib/{libblkid,libcom_err,libe2p,libext2fs,libss,libuuid}.a

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i -e 's@/bin/rm@/tools&@' lib/blkid/test_probe.in
	mkdir -v build
	cd build ; ../configure --prefix=/usr --with-root-prefix="" \
	 --enable-elf-shlibs
	cd build ; make
	cd build ; make install
	cd build ; make install-libs
	chmod -v u+w /usr/lib/{libblkid,libcom_err,libe2p,libext2fs,libss,libuuid}.a
	gunzip -v /usr/share/info/libext2fs.info.gz
	install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info
	cd build ; makeinfo -o doc/com_err.info ../lib/et/com_err.texinfo
	cd build ; install -v -m644 doc/com_err.info /usr/share/info
	install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info
	cd build ; install -v -m644 -D ../doc/libblkid.txt /usr/share/doc/e2fsprogs-1.41.3/libblkid.txt

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage1 chroot compile-stage2
