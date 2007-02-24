# Gawk Makefile

NM= gawk
VRS= 3.1.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 0d5694461f1c32f1eae41a1c0d7ba0939b47e369

PATCH1= $(DIR)-segfault_fix-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 8dde8415d03b1897f50d5b12b6c876feda15e0be

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)

compile-stage1:
	./configure --prefix=$(WD)
	echo "#define HAVE_LANGINFO_CODESET 1" >> config.h
	echo "#define HAVE_LC_MESSAGES 1" >> config.h
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --libexecdir=/usr/lib
	echo "#define HAVE_LANGINFO_CODESET 1" >> config.h
	echo "#define HAVE_LC_MESSAGES 1" >> config.h
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
