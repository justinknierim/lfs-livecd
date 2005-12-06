# Grep Makefile

# Do not update this package before RedHat! Some of the fixes are scheduled
# for grep-2.5.3, not 2.5.2

NM= grep
VRS= 2.5.1a
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 2cd082775d30be463c0ac674a00595eb56fda22e

PATCH50= $(DIR)-redhat_fixes-1.patch
URL-$(PATCH50)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH50)
SHA-$(PATCH50)= cd2f9c8efeed69efb98bebbb07a104b1c842cfb0

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build) # See the scripts/functions file for functions like this
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
ifndef CROSS
	./configure --prefix=$(WD) --disable-perl-regexp
else
	CC="$${CC} $(64FLAGS)" ./configure --prefix=$(WD) \
	 --host=$(LFS_TARGET) --disable-perl-regexp
endif
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH50)
	$(std_build)
	cp $(SRC)/$(PATCH50) $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH50)
ifndef CROSS
	./configure --prefix=/usr --bindir=/bin
else
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr \
	 --bindir=/bin
endif
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
