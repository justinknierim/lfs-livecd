# Bash Makefile

NM= bash
VRS= 3.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 766e3fd9384616d8a103f812f662fd8ec791c129

PATCH1= $(DIR)-fixes-8.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 03d6781dd9ad6336eda906d5645c166e1641dd49

FILE1 = $(NM)-doc-$(VRS).tar.gz
URL-$(FILE1)= $(HTTP)/$(NM)/$(FILE1)
SHA-$(FILE1)= 9cacbbdf3b1be03819b1ea82cdaec0f5e61570c1

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage1:
	./configure --prefix=$(WD) --without-bash-malloc
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
	./configure --prefix=/usr --bindir=/bin --without-bash-malloc \
	 --with-installed-readline
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
