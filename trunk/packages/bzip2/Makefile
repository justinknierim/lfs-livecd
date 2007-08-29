# Bzip2 Makefile

NM= bzip2
VRS= 1.0.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.bzip.org/$(VRS)/$(FILE)
SHA-$(FILE)= f2388ec8f2c506e02aa89e67577b3c6331cbaa4c

PATCH1= $(DIR)-install_docs-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/6.3/$(PATCH1)
SHA-$(PATCH1)= 86fa168b260bb12651ebfa6d47939e926e067036

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	make
	make PREFIX=$(WD) install

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	sed -i 's,X)/man,X)/share/man,g' Makefile
	make -f Makefile-libbz2_so
	make clean
	make
	make PREFIX=/usr install
	cp -v bzip2-shared /bin/bzip2
	cp -av libbz2.so* /lib
	ln -svf ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
	rm -v /usr/bin/{bunzip2,bzcat,bzip2}
	ln -svf bzip2 /bin/bunzip2
	ln -svf bzip2 /bin/bzcat

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
