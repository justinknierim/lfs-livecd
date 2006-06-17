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

STAGE2_DEPS = $(FILE)

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage1:
	patch -Np1 -i ../$(PATCH1)
	./configure.gnu --prefix=$(WD) \
	 -Dstatic_ext='Data/Dumper Fcntl IO POSIX' \
	 -Darchname=$${LFS_TARGET%%-*}-linux \
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

compile-stage2:
	./configure.gnu --prefix=/usr \
	    -Dman1dir=/usr/share/man/man1 \
	    -Dman1dir=/usr/share/man/man1 \
	    -Dpager="/usr/bin/less -isR" \
	    -Duseshrplib=true \
	    -Darchname=$${LFS_TARGET%%-*}-linux
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
