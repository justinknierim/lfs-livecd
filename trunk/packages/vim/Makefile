# Vim Makefile

NM= vim
VRS= 7.0
DIR= $(NM)70

FILE= $(NM)-$(VRS).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 38ef48cabf942d0dc804a794dcc6f002b9457fc8

FILE2= $(NM)-$(VRS)-lang.tar.gz
URL-$(FILE2)= $(HTTP)/$(NM)/$(FILE2)
SHA-$(FILE2)= 3db6b0004d213490cc00d361835e7a7c685adb52

PATCH1= $(NM)-$(VRS)-fixes-16.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/development/$(PATCH1)
SHA-$(PATCH1)= 548bfc2931fe34d4f9c52cf6a357607f524b38a6

PATCH2= $(NM)-$(VRS)-mandir-1.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 182f46dfacefdd3bf6f821dea71f90547d414230

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

chroot3:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make chroot-gvim $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE2) $(PATCH1) $(PATCH2)
	$(std_build)

compile-stage2:
	unpack ../$(FILE2) --strip-components=1
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
	./configure --prefix=/usr --enable-multibyte
	make
	make install
	ln -sfv vim /usr/bin/vi
	for L in "" fr it pl ru ; do \
	    ln -sfv vim.1 /usr/share/man/$L/man1/vi.1 ; done
	ln -sfv ../vim/$(DIR)/doc /usr/share/doc/vim-$(VRS)
	cp $(ROOT)/etc/vimrc /etc

stage3: Makefile $(FILE) $(FILE2) $(PATCH1) $(PATCH2) $(PATCH3)
	$(std_build)

compile-stage3:
	unpack ../$(FILE2) --strip-components=1
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
	echo '#define SYS_GVIMRC_FILE "/etc/gvimrc"' >> src/feature.h
	./configure --prefix=/usr --with-features=huge
	make
	make install
	ln -sfv vim /usr/bin/vi
	for L in "" fr it pl ru ; do \
	    ln -sfv vim.1 /usr/share/man/$L/man1/vi.1 ; done
	ln -sfv ../vim/$(DIR)/doc /usr/share/doc/vim-$(VRS)
	cp $(ROOT)/etc/vimrc /etc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2 compile-stage3
