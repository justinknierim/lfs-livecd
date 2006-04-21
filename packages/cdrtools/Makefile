# CDRTools Makefile

NM= cdrtools
VRS= 2.01
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= f94cfe51dd512d4e0b9106b986bde12d4f7967ce

# Strictly speaking, this is not needed for making the LFS Live CD because
# filenames on the LiveCD don't contain non-ASCII characters, but
# without this patch you can't make a Windows-readabe CD with non-ASCII
# filenames in UTF-8 locale.

PATCH1= $(DIR)-mkisofs_iconv-10.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH1)
SHA-$(PATCH1)= 4a4d6a784e57678a865844021f52fe5fad3623bb

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	# downconvert messages from ISO-8859-1 to ASCII to make
	# sure that they are readable everywhere
	#
	# RedHat's cdrtools-2.01a27-UTF8.patch changes the same
	# messages, but converts them to UTF-8 instead since
	# encodings other than UTF-8 are not supported by RedHat
	for F in cdrecord/cdrecord.c cdrecord/diskid.c cdrecord/sector.c \
	         readcd/readcd.c scgcheck/scgcheck.c scgskeleton/skel.c ; do \
	    LC_ALL=de_DE iconv -f ISO-8859-1 -t US-ASCII//TRANSLIT $$F >tmp ; \
	    mv tmp $$F ; done
	patch -Np1 -i ../$(PATCH1)
	make $(PM) INS_BASE=/tools DEFINSUSR=root DEFINSGRP=root
	make INS_BASE=/tools DEFINSUSR=root DEFINSGRP=root install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
