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

PATCH2= $(DIR)-update_db_file-1.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= e5f94cf06a6fa9ed1339e6e6fbfb3e972a83f849

PATCH3= $(DIR)-sprintf_vulnerability-1.patch
URL-$(PATCH3)= $(HTTP)/$(NM)/$(PATCH3)
SHA-$(PATCH3)= dda2881adffd5407881778f8daa6a959ec2ad589

PATCH40= $(DIR)-Configure_multilib-1.patch
URL-$(PATCH40)= $(HTTP)/$(NM)/$(PATCH40)
SHA-$(PATCH40)= e2c53f1de5b116f75cfb6c92219012fff9494f78

PATCH41= $(DIR)-libc_lib64-1.patch
URL-$(PATCH41)= $(HTTP)/$(NM)/$(PATCH41)
SHA-$(PATCH41)= 111f00a3baadaa4551fdaee3599e95401f81aa53

include $(CROSSVARS)

STAGE2_DEPS = $(FILE) $(PATCH2) $(PATCH3)

# Targets

include $(ROOT)/scripts/functions

ifdef CROSS
STAGE2_DEPS += $(PATCH40) $(PATCH41)
endif

stage1: $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage1:
	patch -Np1 -i ../$(PATCH1)
	./configure.gnu --prefix=$(WD) -Dstatic_ext='Data/Dumper Fcntl IO POSIX' \
	 $(EXTRA_CONF)
	make perl utilities
	cp perl pod/pod2man $(WD)/bin
	mkdir -p $(WD)/lib/perl5/$(VRS)
	cp -R lib/* $(WD)/lib/perl5/$(VRS)

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(STAGE2_DEPS)
	$(std_build)
	cp $(SRC)/{$(PATCH2),$(PATCH3)} $(LFSSRC)
ifdef CROSS
	cp $(SRC)/{$(PATCH40),$(PATCH41)} $(LFSSRC)
endif

compile-stage2:
	patch -Np1 -i ../$(PATCH2)
	patch -Np1 -i ../$(PATCH3)
ifndef CROSS
	./configure.gnu --prefix=/usr -Dpager="/usr/bin/less -isR"
else
	patch -Np1 -i ../$(PATCH40)
	patch -Np1 -i ../$(PATCH41)
	chmod u+w hints/linux.sh
	echo "installstyle=\"lib64/perl5\"" >> hints/linux.sh
	./configure.gnu --prefix=/usr -Dpager="/bin/less -isR" \
	 -Dlibpth="/usr/local/lib64 /lib64 /usr/lib64" \
	 -Dcc="gcc $(64FLAGS)"
endif
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
