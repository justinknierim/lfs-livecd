# Gettext Makefile

NM= gettext
VRS= 0.14.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 68737eee1a6427044eef901dc88e4144d371fb6b

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
	cd $(NM)-tools ; ./configure --prefix=$(WD) --disable-shared
	cd $(NM)-tools ; make -C lib
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
