# Gettext Makefile

NM= gettext
VRS= 0.17
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= c51803d9f745f6ace36bd09c0486d5735ce399cf

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	cd $(NM)-tools ; ./configure --prefix=$(WD) --disable-shared
	cd $(NM)-tools ; make -C gnulib-lib
	cd $(NM)-tools ; make -C src msgfmt
	cd $(NM)-tools ; cp -v src/msgfmt $(WD)/bin

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --docdir=/usr/share/doc/$(DIR)
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
