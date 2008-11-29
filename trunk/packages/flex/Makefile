# Flex Makefile

NM= flex
VRS= 2.5.35
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= c507095833aaeef2d6502e12638e54bf7ad2f24a

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make
	make install
	ln -sfv libfl.a /usr/lib/libl.a
	echo "#!/bin/sh" > /usr/bin/lex
	echo "# Begin /usr/bin/lex" >> /usr/bin/lex
	echo "" >> /usr/bin/lex
	echo "exec /usr/bin/flex -l \"\$$@\"" >> /usr/bin/lex
	echo "" >> /usr/bin/lex
	echo "# End /usr/bin/lex" >> /usr/bin/lex
	chmod 755 /usr/bin/lex
	mkdir -v /usr/share/doc/$(DIR)
	cp -v doc/flex.pdf /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
