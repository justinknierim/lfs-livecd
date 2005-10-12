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

PATCH40= $(DIR)-lib64-1.patch

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage1:
	patch -Np1 -i ../$(PATCH1)
ifeq ($(LFS-ARCH),x86_64)
	sed -i 's@\$${prefix}/lib@\$${prefix}/lib64@g' hints/linux.sh
	patch -Np1 -i ../$(PATCH40)
	chmod u+w hints/linux.sh
	echo "installstyle=\"lib64/perl5\"" >> hints/linux.sh
endif
	./configure.gnu --prefix=$(WD) -Dstatic_ext='IO Fcntl POSIX'
	make perl utilities
	cp perl pod/pod2man $(WD)/bin
ifneq ($(LFS-ARCH),x86_64)
	mkdir -p $(WD)/lib/perl5/$(VRS)
	cp -R lib/* $(WD)/lib/perl5/$(VRS)
else
	mkdir -p $(WD)/lib64/perl5/$(VRS)
	cp -R lib/* $(WD)/lib64/perl5/$(VRS)
endif

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
