# Tar Makefile

NM= tar
VRS= 1.15.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= f861b7524a0867833056dc382e68085234cae6ff

PATCH1= $(DIR)-gcc4_fix_tests-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= ba780e0e88c7993a69d5a498912e135bf16e7df8

PATCH2= $(DIR)-sparse_fix-1.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 269dfcc556b6217d27d043ea623df75e19e3d8c9


# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)/

compile-stage1:
ifneq ($(LFS-ARCH),x86_64)
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=$(WD)
else
	echo "am_cv_func_working_getline=yes" >> config.cache
	CC="$${CC} $(64FLAGS)" ./configure --prefix=$(WD) \
   	 --host=$(LFS_TARGET) --cache-file=config.cache
endif
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)
	cp $(SRC)/$(PATCH2) $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
ifndef CROSS
	./configure --prefix=/usr --bindir=/bin --libexecdir=/usr/sbin
else
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr \
   	 --bindir=/bin --libexecdir=/usr/sbin
endif
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
