# Flex Makefile

NM= flex
VRS= 2.5.31
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= c305d08a469625658418cb8f2d66c66fce1b76e5

PATCH1= $(DIR)-debian_fixes-3.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= aafb7a09fa8ffe4d3db0737df6ac39d26f93e072

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage2:
	patch -Np1 -Z -i ../$(PATCH1)
	touch doc/flex.1
ifndef CROSS
	./configure --prefix=/usr
else
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr \
	 --libdir=/usr/lib64
endif
	make $(PM)
	make install
	ln -s libfl.a /usr/$(LIB_MAYBE64)/libl.a
	echo "#!/bin/sh" > /usr/bin/lex
	echo "# Begin /usr/bin/lex" >> /usr/bin/lex
	echo "" >> /usr/bin/lex
	echo "exec /usr/bin/flex -l \"\$$@\"" >> /usr/bin/lex
	echo "" >> /usr/bin/lex
	echo "# End /usr/bin/lex" >> /usr/bin/lex
	chmod 755 /usr/bin/lex

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
