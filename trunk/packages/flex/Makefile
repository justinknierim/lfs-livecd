# Flex Makefile

NM= flex
VRS= 2.5.33
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= acdb8fff6455967ad1a5bfc71855dbcc1253ee56

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	./configure --prefix=/usr
	make $(PM)
	make install
	ln -sfv libfl.a /usr/$(LIB_MAYBE64)/libl.a
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
