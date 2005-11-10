# Vim Makefile

NM= vim
VRS= 6.4
DIR= $(NM)64

FILE= $(NM)-$(VRS).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 4ecc16d704b303db25c52c6bc33ab65e661ace93

FILE2= $(NM)-$(VRS)-lang.tar.bz2
URL-$(FILE2)= $(HTTP)/$(NM)/$(FILE2)
SHA-$(FILE2)= 91ac269d6dbeff880b38d6b955a112bb591b62d7

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
ifndef CROSS
	./configure --prefix=/usr --enable-multibyte
else
	CC="gcc $(64FLAGS)" CXX="g++ $(64FLAGS)" \
	 ./configure --prefix=/usr --enable-multibyte
endif
	make $(PM)
	make HELPSUBLOC=/usr/share/doc/vim-6.4 install
	ln -sf vim /usr/bin/vi
	cp $(ROOT)/etc/vimrc /etc

stage3: Makefile $(FILE) $(FILE2) $(PATCH1)
	$(std_build)

compile-stage3:
	unpack ../$(FILE2) --strip-components=1
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
	echo '#define SYS_GVIMRC_FILE "/etc/gvimrc"' >> src/feature.h
	./configure --prefix=/usr --with-features=huge
	make $(PM)
	make install
	ln -sf vim /usr/bin/vi
	cp $(ROOT)/etc/vimrc /etc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2 compile-stage3
