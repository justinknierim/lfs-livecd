# Vim Makefile

NM= vim
VRS= 7.2
DIR= $(NM)72

FILE= $(NM)-$(VRS).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= a4b6641ca528fada71ea77c998a441495ed4984c

FILE2= $(NM)-$(VRS)-lang.tar.gz
URL-$(FILE2)= $(HTTP)/$(NM)/$(FILE2)
SHA-$(FILE2)= 970e0dda7e5b2308cf33488be1ea33d593d951cb

PATCH1= $(NM)-$(VRS)-fixes-3.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= ba16e6b8749d686dd21672017f76ef0671922d22

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

chroot3:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make chroot-gvim $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE2) $(PATCH1)
	$(std_build)

compile-stage2:
	unpack ../$(FILE2) --strip-components=1
	patch -Np1 -i ../$(PATCH1)
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
	./configure --prefix=/usr --enable-multibyte
	make
	make install
	ln -sfv vim /usr/bin/vi
	for L in /usr/share/man/{,*/}man1/vim.1 ; do \
	    ln -sfv vim.1 $$(dirname $$L)/vi.1 ; done
	ln -sfv ../vim/$(DIR)/doc /usr/share/doc/vim-$(VRS)
	cp $(ROOT)/etc/vimrc /etc

stage3: Makefile $(FILE) $(FILE2) $(PATCH1) $(PATCH2)
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
	ln -nsfv ../vim/$(DIR)/doc /usr/share/doc/vim-$(VRS)
	cp $(ROOT)/etc/vimrc /etc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2 compile-stage3
