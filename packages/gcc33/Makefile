# Gcc 3.3.6 Makefile

NM= gcc
VRS= 3.3.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/gnu/gcc/$(DIR)/$(FILE)
SHA-$(FILE)= 2cc43978bb09af6c2ccfdf74797d10d7cc2596fb

PATCH1= $(DIR)-no_fixincludes-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/blfs/svn/$(PATCH1)
SHA-$(PATCH1)= 0ff124e669753a80050fe8b8746067d3eb8503b1

PATCH2= $(DIR)-linkonce-1.patch
URL-$(PATCH2)= http://www.linuxfromscratch.org/patches/blfs/svn/$(PATCH2)
SHA-$(PATCH2)= dd73dfe163ec16b59d3f258e7d60099a8c8de424

# Targets

include $(ROOT)/scripts/functions

unexport CFLAGS CXXFLAGS

export LFS_USE_TARGET := yes

stage2: $(FILE) $(PATCH1) $(PATCH2)
	$(sep_dir_build)

compile-stage2:
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH1)
	cd ../$(DIR) ; patch -Np1 -i ../$(PATCH2)
# --enable-static overrides the unsuitable default in config.site
	../$(DIR)/configure --prefix=/usr --libexecdir=/usr/lib \
	 --enable-shared --enable-threads=posix --enable-__cxa_atexit \
	 --enable-clocale=gnu --enable-languages=c,c++ --enable-static \
	 --build=$(LFS_TARGET) --host=$(LFS_TARGET) --target=$(LFS_TARGET) \
	 --disable-multilib
	make bootstrap
	cp -av $(LFS_TARGET)/libstdc++-v3/src/.libs/libstdc++.so.5* /usr/lib

clean:
	-rm -rf $(DIR)
	-rm -rf $(NM)-build

.PHONY: clean chroot compile-stage2
