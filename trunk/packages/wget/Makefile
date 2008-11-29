# Wget Makefile

NM= wget
VRS= 1.11.4
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA-$(FILE)= a78a3b71fd59504df3ff3dbc0a2195a1410e9eac

# Targets

include $(ROOT)/scripts/functions

ftpget:
	@if ! which wget >/dev/null 2>&1 ; then cd $(SRC) ; \
	 $(ROOT)/scripts/ftpget $(VRS) ; fi

prebuild: ftpget $(FILE)
	$(std_build)

compile-prebuild:
	unset CFLAGS ; ./configure --prefix=$(WD) --libdir=$(WD)/lib --without-ssl \
	 --enable-static --disable-shared --disable-nls
	unset CFLAGS ; make
	unset CFLAGS ; make install

stage1: $(FILE)
	$(std_build)

compile-stage1:
	./configure --prefix=$(WD) --libdir=$(WD)/lib --without-ssl \
	 --enable-static --disable-shared --disable-nls
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --with-ssl
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-prebuild compile-stage1 clean chroot compile-stage2
