# Sed Makefile

NM= sed
VRS= 4.1.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 8e575e8a44568392d5b6e089eab5da5cdbd45885

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
ifndef CROSS
	./configure --prefix=$(WD)
else
	CC="$${CC} $(64FLAGS)" ./configure --prefix=$(WD) \
	 --host=$(LFS_TARGET)
endif
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's@/doc@&/$(DIR)@' doc/Makefile.in
ifndef CROSS
	./configure --prefix=/usr --bindir=/bin --enable-html
else
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr \
	 --bindir=/bin --enable-html
endif
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
