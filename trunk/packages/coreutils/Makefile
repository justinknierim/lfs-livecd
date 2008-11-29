# Coreutils Makefile

NM= coreutils
VRS= 6.12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 1bb297fdf8b38ca19ab5252c6179b1b2aecd020e

PATCH1= $(DIR)-old_build_kernel-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= ecddf5bafede04807f44c82ca5421b8a59e2ce06

PATCH2= $(DIR)-uname-1.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 42cc795e56b96994a4dc9e8f2a8dd72b6a25665f

PATCH3= $(DIR)-i18n-2.patch
URL-$(PATCH3)= $(HTTP)/$(NM)/$(PATCH3)
SHA-$(PATCH3)= 49d537e71bc4b0c50c13c2a850c369fca1b177de

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)

compile-stage1:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=$(WD) --enable-install-program=hostname
	make
	make install
	cp -v src/su $(WD)/bin/su-tools

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2) $(PATCH3)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	patch -Np1 -i ../$(PATCH3)
	./configure --prefix=/usr --enable-install-program=hostname --enable-no-install-program=kill,uptime
	make
	make install
	$(WD)/bin/mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
	$(WD)/bin/mv -v /usr/bin/{false,hostname,ln,ls,mkdir,mknod,mv,pwd,readlink,rm} /bin
	mv -v /usr/bin/{rmdir,stty,sync,true,uname} /bin
	mv -v /usr/bin/chroot /usr/sbin
	mv -v /usr/bin/{head,sleep,nice} /bin

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
