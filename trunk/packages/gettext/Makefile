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
ifneq ($(LFS-ARCH),x86_64)
	./configure --prefix=$(WD) --disable-libasprintf --without-csharp
else
	echo "am_cv_func_working_getline=yes" >> config.cache
	CC="${CC} ${BUILD64}" CXX="${CXX} ${BUILD64}" \
   	 ./configure --prefix=$(WD) --libdir=$(WD)/lib64 \
   	 --host=$(LFS_TARGET) --disable-libasprintf \
   	 --without-csharp --cache-file=config.cache
endif
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
