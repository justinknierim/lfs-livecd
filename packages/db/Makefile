# DB Makefile

NM= db
VRS= 4.4.16
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://downloads.sleepycat.com/$(FILE)
SHA-$(FILE)= 08ce785ad051ed6e9712201423ddb9045d0cd62c

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
