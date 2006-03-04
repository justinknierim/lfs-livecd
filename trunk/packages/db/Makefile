# DB Makefile

NM= db
VRS= 4.4.16
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= dd03d6f2d3802c8e5f92e650d3be514f47810b39

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
ifndef CROSS
	cd build_unix ; ../dist/configure --prefix=/usr \
	    --enable-compat185 --enable-cxx
else
	cd build_unix ; CC="gcc $(64FLAGS)" ./configure --prefix=/usr \
	    --libdir=/usr/$(LIB_MAYBE64) --enable-compat185 --enable-cxx
endif
	cd build_unix ; make
	cd build_unix ; make docdir=/usr/share/doc/$(DIR) install
	chown root:root /usr/bin/db_* /usr/lib/libdb* /usr/include/db*
	chown -R root:root /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
