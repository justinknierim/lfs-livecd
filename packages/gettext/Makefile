# Gettext Makefile

NM= gettext
VRS= 0.14.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 68737eee1a6427044eef901dc88e4144d371fb6b

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
ifndef CROSS
	cd $(NM)-tools ; ./configure --prefix=$(WD) --disable-shared
else
	cd $(NM)-tools ; echo "am_cv_func_working_getline=yes" >> config.cache
	cd $(NM)-tools ; CC="$${CC} $(64FLAGS)" CXX="$${CXX} $(64FLAGS)" \
	 ./configure --prefix=$(WD) --host=$(LFS_TARGET) --disable-shared \
	 --cache-file=config.cache
endif
	cd $(NM)-tools ; make -C lib
	cd $(NM)-tools ; make -C src msgfmt
	cd $(NM)-tools ; cp -v src/msgfmt $(WD)/bin

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
