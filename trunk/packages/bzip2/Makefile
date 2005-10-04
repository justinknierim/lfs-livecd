# Bzip2 Makefile

NM= bzip2
VRS= 1.0.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 8726fce88aeeb11923f2a83225beac37b9a42dab

PATCH1= $(DIR)-install_docs-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= ead85296356efe99db45529cf7aeb9f61dd33daa

PATCH2= $(DIR)-bzgrep_security-1.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 56a29bf1278f21bc30c72d19e5766bfda5c74e5b

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
	make $(PM)
	make PREFIX=$(WD) install

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)
	cp $(SRC)/{$(PATCH1),$(PATCH2)} $(LFSSRC)/

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	make $(PM) -f Makefile-libbz2_so
	make clean
	make $(PM)
	make install
	cp bzip2-shared /bin/bzip2 && cp -a libbz2.so* /lib
	ln -s ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
	rm /usr/bin/{bunzip2,bzcat,bzip2}
	ln -s bzip2 /bin/bunzip2 && ln -s bzip2 /bin/bzcat

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
