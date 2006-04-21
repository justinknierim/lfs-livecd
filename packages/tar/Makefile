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

PATCH3= $(DIR)-security_fixes-1.patch
URL-$(PATCH3)= $(HTTP)/$(NM)/$(PATCH3)
SHA-$(PATCH3)= 93fd5a55bccf25d03bb7e18dffc0bce27c29d207

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)/

compile-stage1:
ifndef CROSS
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

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2) $(PATCH3)
	$(std_build)
	cp $(SRC)/{$(PATCH2),$(PATCH3)} $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	patch -Np1 -i ../$(PATCH3)
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
