# Vim Makefile

NM= vim
VRS= 6.4
DIR= $(NM)64

FILE= $(NM)-$(VRS).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 4ecc16d704b303db25c52c6bc33ab65e661ace93

FILE2= $(NM)-$(VRS)-lang.tar.gz
URL-$(FILE2)= $(HTTP)/$(NM)/$(FILE2)
SHA-$(FILE2)= 4b80d0f2a0643ab942a9297b88a5447f654e998e

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

chroot3:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make chroot-gvim $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE2)
	$(std_build)
	cp $(SRC)/{$(FILE),$(FILE2)} $(LFSSRC)

compile-stage2:
	unpack ../$(FILE2) --strip-components=1
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
	./configure --prefix=/usr --enable-multibyte
	make $(PM)
	make install
	rm -f /usr/share/vim/$(DIR)/tutor/tutor.{gr,pl,ru,sk}
	rm -f /usr/share/vim/$(DIR)/tutor/tutor.??.*
	ln -sfv vim /usr/bin/vi
	ln -sfv vim.1 /usr/share/man/man1/vi.1
	ln -sfv ../vim/$(DIR)/doc /usr/share/doc/vim-$(VRS)
	cp $(ROOT)/etc/vimrc /etc

stage3: Makefile $(FILE) $(FILE2)
	$(std_build)

compile-stage3:
	unpack ../$(FILE2) --strip-components=1
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
	echo '#define SYS_GVIMRC_FILE "/etc/gvimrc"' >> src/feature.h
	./configure --prefix=/usr --with-features=huge
	make $(PM)
	make install
	rm -f /usr/share/vim/$(DIR)/tutor/tutor.{gr,pl,ru,sk}
	rm -f /usr/share/vim/$(DIR)/tutor/tutor.??.*
	ln -sfv vim /usr/bin/vi
	ln -sfv vim.1 /usr/share/man/man1/vi.1
	ln -sfv ../vim/$(DIR)/doc /usr/share/doc/vim-$(VRS)
	cp $(ROOT)/etc/vimrc /etc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2 compile-stage3
