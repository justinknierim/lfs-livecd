# Perl Makefile

NM= perl
VRS= 5.8.7
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= c9477c6fe76b200033694bdc555a0276523d4228

PATCH1= $(DIR)-libc-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= e515154714acdbb1dbdbeb71727649895e26f50d

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage1:
	patch -Np1 -i ../$(PATCH1)
	./configure.gnu --prefix=$(WD) -Dstatic_ext='IO Fcntl POSIX'
	make perl utilities
	cp perl pod/pod2man $(WD)/bin
	mkdir -p $(WD)/lib/perl5/$(VRS)
	cp -R lib/* $(WD)/lib/perl5/$(VRS)

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure.gnu --prefix=/usr -Dpager="/bin/less -isR"
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
