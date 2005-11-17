# Gettext Makefile

NM= gettext
VRS= 0.14.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= eaea6cb53693cca785831b98c6d7359423d33e6e

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
ifndef CROSS
	cd gettext-tools
	./configure --prefix=$(WD) --disable-shared
	make -C lib
	make -C src msgfmt
	cp -v src/msgfmt $(WD)/bin
else
	echo "am_cv_func_working_getline=yes" >> config.cache
	CC="$${CC} $(64FLAGS)" CXX="$${CXX} $(64FLAGS)" \
   	 ./configure --prefix=$(WD) --libdir=$(WD)/lib64 \
   	 --host=$(LFS_TARGET) --disable-libasprintf \
   	 --without-csharp --cache-file=config.cache
	make
	make install
endif

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
ifndef CROSS
	./configure --prefix=/usr
else
ifeq ($(LFS-ARCH),x86_64)
	sed -i -e '2iexit 77' autoconf-lib-link/tests/rpath-3*[ef]
endif
	CC="gcc $(64FLAGS)" CXX="g++ $(64FLAGS)" \
	 ./configure --prefix=/usr --libdir=/usr/lib64
endif
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
