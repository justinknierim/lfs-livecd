# Perl Makefile

NM= perl
VRS= 5.8.8
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 4aab490040727ca4419098720eca2ba4367df539

PATCH1= $(DIR)-libc-2.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= b72468149c5eee6faefde7f32bb05bda6e2a1c9d

PATCH40= $(DIR)-Configure_multilib-1.patch
URL-$(PATCH40)= $(HTTP)/$(NM)/$(PATCH40)
SHA-$(PATCH40)= e2c53f1de5b116f75cfb6c92219012fff9494f78

PATCH41= $(DIR)-libc_lib64-1.patch
URL-$(PATCH41)= $(HTTP)/$(NM)/$(PATCH41)
SHA-$(PATCH41)= 111f00a3baadaa4551fdaee3599e95401f81aa53

include $(CROSSVARS)

STAGE2_DEPS = $(FILE)

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
ifdef CROSS
	cp $(SRC)/{$(PATCH40),$(PATCH41)} $(LFSSRC)
endif

compile-stage2:
ifndef CROSS
	./configure.gnu --prefix=/usr \
	    -Dman1dir=/usr/share/man/man1 \
	    -Dman1dir=/usr/share/man/man1 \
	    -Dpager="/usr/bin/less -isR"
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
