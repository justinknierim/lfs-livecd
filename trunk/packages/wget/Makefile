# Wget Makefile

NM= wget
VRS= 1.10.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA-$(FILE)= a258357297959964fd42fed6afa1a4cce9069980

# Targets

include $(ROOT)/scripts/functions

ftpget:
	@if ! which wget >/dev/null 2>&1 ; then cd $(SRC) ; \
	 $(ROOT)/scripts/ftpget $(VRS) ; fi

prebuild: ftpget $(FILE)
	$(std_build)

compile-prebuild:
	./configure --prefix=$(WD) --libdir=$(WD)/lib --without-ssl \
	 --enable-static --disable-shared --disable-nls
	make $(PM)
	make install

stage1: $(FILE)
	$(std_build)

compile-stage1:
	./configure --prefix=$(WD) --libdir=$(WD)/lib --without-ssl \
	 --enable-static --disable-shared --disable-nls
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --with-ssl
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-prebuild compile-stage1 clean chroot compile-stage2
