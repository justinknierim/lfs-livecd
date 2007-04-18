# Coreutils Makefile

NM= coreutils
VRS= 6.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/gnu/coreutils/$(FILE)
SHA-$(FILE)= 10310a78c4e1d9f742f3815ac28e9bf1086a5885

PATCH1= $(DIR)-uname-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/development/$(PATCH1)
SHA-$(PATCH1)= 42cc795e56b96994a4dc9e8f2a8dd72b6a25665f

PATCH2= $(DIR)-suppress_uptime_kill_su-1.patch
URL-$(PATCH2)= http://www.linuxfromscratch.org/patches/lfs/development/$(PATCH2)
SHA-$(PATCH2)= e1e783efd515639b78627c37025b96168594f408

PATCH3= $(DIR)-i18n-1.patch
URL-$(PATCH3)= http://www.linuxfromscratch.org/patches/lfs/development/$(PATCH3)
SHA-$(PATCH3)= 5db7b7919910ccda018d01f2fc1b65e1c1da954d

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	./configure --prefix=$(WD)
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2) $(PATCH3)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	patch -Np1 -i ../$(PATCH3)
	chmod +x tests/sort/sort-mb-tests
	./configure --prefix=/usr
	make
	make install
	$(WD)/bin/mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
	$(WD)/bin/mv -v /usr/bin/{false,hostname,ln,ls,mkdir,mknod,mv,pwd,rm} /bin
	mv -v /usr/bin/{rmdir,stty,sync,true,uname} /bin
	mv -v /usr/bin/chroot /usr/sbin
	mv -v /usr/bin/{head,sleep,nice} /bin

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
