# Bash Makefile

NM= bash
VRS= 3.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 35e8f7eadded3be38df2eb8ac8db094109339d5e

PATCH1= $(DIR)-fixes-8.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 03d6781dd9ad6336eda906d5645c166e1641dd49

FILE1 = $(NM)-doc-$(VRS).tar.bz2
URL-$(FILE1)= $(HTTP)/$(NM)/$(FILE1)
SHA-$(FILE1)= 21084bf998eb11b9c30cd6dac72471ee980cc893

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage1:
ifndef CROSS
	./configure --prefix=$(WD) --without-bash-malloc
else
	cp Makefile.in Makefile.in.orig
	sed "s@size \$$(Program)@$(LFS_TARGET)-&@g"  Makefile.in.orig > Makefile.in
	echo "ac_cv_func_setvbuf_reversed=no" >> config.cache
	CC="$${CC} $(64FLAGS)" CXX="$${CXX} $(64FLAGS)" \
	 ./configure --prefix=$(WD) \
	 --without-bash-malloc --host=$(LFS_TARGET) \
	 --cache-file=config.cache
endif
	make
	make install
	ln -sv bash $(WD)/bin/sh

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(FILE1)
	$(std_build)
	cp $(SRC)/$(FILE1) $(LFSSRC)/

compile-stage2:
	unpack ../$(FILE1)
	sed -i "s|htmldir = @htmldir@|htmldir = /usr/share/doc/$(DIR)|" \
	 Makefile.in
	patch -Np1 -i ../$(PATCH1)
ifndef CROSS
	./configure --prefix=/usr --bindir=/bin --without-bash-malloc \
	 --with-installed-readline
else
	CC="gcc $(64FLAGS)" CXX="g++ $(64FLAGS)" \
	 ./configure --prefix=/usr --bindir=/bin \
	 --without-bash-malloc --with-installed-readline
endif
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
