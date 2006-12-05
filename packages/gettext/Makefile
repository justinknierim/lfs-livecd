# Gettext Makefile

NM= gettext
VRS= 0.16
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= ab42a62fcfbfc5adde199375a20c0ae252b40961

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

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
	./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
