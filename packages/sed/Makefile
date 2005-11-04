# Sed Makefile

NM= sed
VRS= 4.1.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 3e2c884252920cced7b636826bf9a99d7d3e8437

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
	./configure --prefix=/usr --bindir=/bin
else
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr \
	 --bindir=/bin
endif
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2