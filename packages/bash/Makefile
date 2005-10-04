# Bash Makefile

NM= bash
VRS= 3.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= eaa39bae5dccf44a48593858009fb3dc01d4346a

FILE1 = $(NM)-doc-$(VRS).tar.bz2
URL-$(FILE1)= $(HTTP)/$(NM)/$(FILE1)
SHA-$(FILE1)= ffb7d4920becfc0acc5a4068ab5b5f09300733cf

PATCH1= $(DIR)-avoid_WCONTINUED-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 3ea7cf640d5bcf5e442654986e53e6a796ba996e

PATCH2= $(DIR)-fixes-3.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= f5dc122edaac230856d208a5787a3b346959a034

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage1:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=$(WD) --without-bash-malloc
	make
	make install
	ln -s bash $(WD)/bin/sh

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(FILE1) $(PATCH1) $(PATCH2)
	$(std_build)
	cp $(SRC)/{$(PATCH2),$(FILE1)} $(LFSSRC)/

compile-stage2:
	unpack ../$(FILE1)
	sed -i "s|htmldir = @htmldir@|htmldir = /usr/share/doc/bash-3.0|" \
	 Makefile.in
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	./configure --prefix=/usr --bindir=/bin --without-bash-malloc \
	 --with-installed-readline
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
