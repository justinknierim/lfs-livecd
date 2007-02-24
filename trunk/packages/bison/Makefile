# Bison Makefile

NM= bison
VRS= 2.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 7e489f35c6d8171f0cb0cad3dda0fb39f2cb0b62

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	echo '#define YYENABLE_NLS 1' >> config.h
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
