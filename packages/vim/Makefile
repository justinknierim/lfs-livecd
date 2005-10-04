# Vim Makefile

NM= vim
VRS= 6.3
DIR= $(NM)63

FILE= $(NM)-$(VRS).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 76f663277140d314ecfafecb0307e832bdbbaf06

FILE2= $(NM)-$(VRS)-lang.tar.bz2
URL-$(FILE2)= $(HTTP)/$(NM)/$(FILE2)
SHA-$(FILE2)= de6df42164d875ff0cf8b1fb16fb210fd21b6938

PATCH1= $(NM)-$(VRS)-security_fix-2.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 97c323f0c6ff807d89e8e3ce64f20101a097f281

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
	cp $(SRC)/{$(FILE),$(FILE2),$(PATCH1)} $(LFSSRC)

compile-stage2:
	unpack ../$(FILE2) --strip-components=1
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --enable-multibyte
	make $(PM)
	make install
	ln -sf vim /usr/bin/vi
	cp $(ROOT)/etc/vimrc /etc

stage3: Makefile $(FILE) $(FILE2) $(PATCH1)
	$(std_build)

compile-stage3:
	unpack ../$(FILE2) --strip-components=1
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
	echo '#define SYS_GVIMRC_FILE "/etc/gvimrc"' >> src/feature.h
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --with-features=huge
	make $(PM)
	make install
	ln -sf vim /usr/bin/vi
	cp $(ROOT)/etc/vimrc /etc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2 compile-stage3
