# Ncurses Makefile

NM= ncurses
VRS= 5.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= e4911dd9688a8e3ebf5faa97efd2eb9790b0c1d9

PATCH1= $(DIR)-20050827-patch.sh.bz2
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 7da2e2ae84d49466ff777b4d815318391776e21b

# Just for $(PATCH3) not to fail
PATCH2= $(DIR)-20050903.patch.gz
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 7012562cf189879484addcaacb128cefb8f89c72

# Fix for double Gpm_Open()
PATCH3= $(DIR)-20050910.patch.gz
URL-$(PATCH3)= $(HTTP)/$(NM)/$(PATCH3)
SHA-$(PATCH3)= 3078547c70c63cc03fa9a1ea298aa701771c42eb

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
	./configure --prefix=$(WD) --with-shared --without-debug \
	 --without-ada --enable-overwrite
	make sources
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	bzcat ../$(PATCH1) > update.sh
	sh update.sh
	zcat ../$(PATCH2) | patch -Np1
	zcat ../$(PATCH3) | patch -Np1
ifeq ($(LFS-ARCH),sparc)
	./configure --prefix=/usr --with-shared --without-debug
else
	./configure --prefix=/usr --with-shared --without-debug --with-gpm
endif
	make sources
	make $(PM)
	make install
	chmod 755 /usr/lib/*.5.4
	chmod 644 /usr/lib/libncurses++.a && mv /usr/lib/libncurses.so.5* /lib
	ln -sf ../../lib/libncurses.so.5 /usr/lib/libncurses.so
	ln -sf libncurses.so /usr/lib/libcurses.so

clean:
	-rm -rf $(DIR)
	rm -f update.sh 

.PHONY: compile-stage1 clean chroot compile-stage2
