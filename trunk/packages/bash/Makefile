# Bash Makefile

NM= bash
VRS= 3.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= fe6466c7ee98061e044dae0347ca5d1a8eab4a0d

PATCH1= $(DIR)-fixes-8.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= b7366d418e292b64ac089f99056e59043d7decde

FILE1 = $(NM)-doc-$(VRS).tar.gz
URL-$(FILE1)= $(HTTP)/$(NM)/$(FILE1)
SHA-$(FILE1)= 30e4a66c0974275384b90ffdbc4f54d53ba3d2b4

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)

compile-stage1:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=$(WD) --without-bash-malloc ac_cv_func_working_mktime=yes
	make
	make install
	ln -sv bash $(WD)/bin/sh

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(FILE1)
	$(std_build)

compile-stage2:
	unpack ../$(FILE1)
	sed -i "s|htmldir = @htmldir@|htmldir = /usr/share/doc/$(DIR)|" \
	 Makefile.in
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --bindir=/bin --without-bash-malloc \
	 --with-installed-readline ac_cv_func_working_mktime=yes
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
