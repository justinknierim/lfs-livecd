# Perl Makefile

NM= perl
VRS= 5.10.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= adf73606dd5248af7ccdd735bcaa0e628ea75b3c

PATCH1= $(DIR)-consolidated-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= b3647660b80408eb281c333fba82432cf400fc01

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)

compile-stage1:
	patch -Np1 -i ../$(PATCH1)
	sh Configure -des -Dprefix=$(WD) \
	 -Dstatic_ext='Data/Dumper Digest/MD5 Fcntl IO POSIX'
	make perl utilities ext/Errno/pm_to_blib
	cp -v perl pod/pod2man $(WD)/bin
	mkdir -pv $(WD)/lib/perl5/$(VRS)
	cp -Rv lib/* $(WD)/lib/perl5/$(VRS)

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	# LFS has:
	# echo "127.0.0.1 localhost $(hostname)" > /etc/hosts
	# this is already taken care of by the createfiles target
	patch -Np1 -i ../$(PATCH1)
	sed -i -e "s|BUILD_ZLIB\s*= True|BUILD_ZLIB = False|" \
	 -e "s|INCLUDE\s*= ./zlib-src|INCLUDE    = /usr/include|" \
	 -e "s|LIB\s*= ./zlib-src|LIB        = /usr/lib|" \
	 ext/Compress/Raw/Zlib/config.in
	sh Configure -des -Dprefix=/usr \
	 -Dvendorprefix=/usr           \
	 -Dman1dir=/usr/share/man/man1 \
	 -Dman3dir=/usr/share/man/man3 \
	 -Dpager="/usr/bin/less -isR"
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
