# Vim Makefile

NM= vim
VRS= 7.0
DIR= $(NM)70

FILE= $(NM)-$(VRS).tar.bz2
URL-$(FILE)= http://ftp.vim.org/pub/vim/unix/$(FILE)
SHA-$(FILE)= 38ef48cabf942d0dc804a794dcc6f002b9457fc8

FILE2= $(NM)-$(VRS)-lang.tar.gz
URL-$(FILE2)= http://ftp.vim.org/pub/vim/extra/$(FILE2)
SHA-$(FILE2)= 3db6b0004d213490cc00d361835e7a7c685adb52

PATCH1= $(NM)-$(VRS)-fixes-7.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/6.2/$(PATCH1)
SHA-$(PATCH1)= caf8b4b5635cf72edd033b048a993f80c5a5aa7b

PATCH2= $(NM)-$(VRS)-mandir-1.patch
URL-$(PATCH2)= http://www.linuxfromscratch.org/patches/lfs/6.2/$(PATCH2)
SHA-$(PATCH2)= 182f46dfacefdd3bf6f821dea71f90547d414230

PATCH3= $(NM)-$(VRS)-spellfile-1.patch
URL-$(PATCH3)= http://www.linuxfromscratch.org/patches/lfs/6.2/$(PATCH3)
SHA-$(PATCH3)= 4e0cb489a9b8f989f154d14cadb50deba619dd2b

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

chroot3:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make chroot-gvim $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE2) $(PATCH1) $(PATCH2) $(PATCH3)
	$(std_build)
	cp $(SRC)/{$(FILE),$(FILE2),$(PATCH1),$(PATCH2),$(PATCH3)} $(LFSSRC)

compile-stage2:
	unpack ../$(FILE2) --strip-components=1
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	patch -Np1 -i ../$(PATCH3)
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
	./configure --prefix=/usr --enable-multibyte
	make $(PM)
	make install
	rm -f /usr/share/vim/$(DIR)/tutor/tutor.{gr,pl,ru,sk}
	rm -f /usr/share/vim/$(DIR)/tutor/tutor.??.*
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
	patch -Np1 -i ../$(PATCH3)
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
	echo '#define SYS_GVIMRC_FILE "/etc/gvimrc"' >> src/feature.h
	./configure --prefix=/usr --with-features=huge
	make $(PM)
	make install
	rm -f /usr/share/vim/$(DIR)/tutor/tutor.{gr,pl,ru,sk}
	rm -f /usr/share/vim/$(DIR)/tutor/tutor.??.*
	ln -sfv vim /usr/bin/vi
	for L in "" fr it pl ru ; do \
	    ln -sfv vim.1 /usr/share/man/$L/man1/vi.1 ; done
	ln -sfv ../vim/$(DIR)/doc /usr/share/doc/vim-$(VRS)
	cp $(ROOT)/etc/vimrc /etc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2 compile-stage3
