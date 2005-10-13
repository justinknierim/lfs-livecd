# Grep Makefile

NM= grep
VRS= 2.5.1a
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 2cd082775d30be463c0ac674a00595eb56fda22e

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build) # See the scripts/functions file for functions like this
	cp $(SRC)/$(FILE) $(LFSSRC) # Copy LFS-Base packages to safe location

compile-stage1:
ifneq ($(LFS-ARCH),x86_64)
	./configure --prefix=$(WD) --disable-perl-regexp
else
	CC="${CC} ${BUILD64}" ./configure --prefix=$(WD) \
   	 --host=$(LFS_TARGET) --disable-perl-regexp
endif
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) 
	$(std_build)

compile-stage2:
ifndef CROSS
	./configure --prefix=/usr --bindir=/bin
else
	CC="gcc ${BUILD64}" ./configure --prefix=/usr \
	 --bindir=/bin
endif
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
