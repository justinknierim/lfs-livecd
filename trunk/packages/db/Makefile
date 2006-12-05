# DB Makefile

NM= db
VRS= 4.4.20
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= bb4c68a4afc14712eb2954b7991f5dc9fe93bf7b

PATCH1= $(DIR)-fixes-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/6.2/$(PATCH1)
SHA-$(PATCH1)= 46886ccdf1ea6daab392e5c46b4923f7e71e7d55

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	cd build_unix ; ../dist/configure --prefix=/usr \
	    --enable-compat185 --enable-cxx
	cd build_unix ; make
	cd build_unix ; make docdir=/usr/share/doc/$(DIR) install
	chown -v root:root /usr/bin/db_* /usr/lib/libdb* /usr/include/db*
	chown -Rv root:root /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
