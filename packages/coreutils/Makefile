# Coreutils Makefile

NM= coreutils
VRS= 5.94
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= c39add02995304e1cf3dfc8543702f22155fba50

PATCH1= $(DIR)-uname-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 42cc795e56b96994a4dc9e8f2a8dd72b6a25665f

PATCH2= $(DIR)-suppress_uptime_kill_su-2.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= a7dedf947b7651f882c8ede00eb6e56689bbb154

PATCH50= $(DIR)-i18n-1.patch
URL-$(PATCH50)= $(HTTP)/$(NM)/$(PATCH50)
SHA-$(PATCH50)= 3ff73ceeae8ef66345cfed38f770e51db4d02199

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
	./configure --prefix=$(WD)
	make $(PM)
	make install
	mv $(WD)/bin/uname $(WD)/bin/uname.real 
	install -m 755 $(MP)$(ROOT)/uname/uname $(WD)/bin/

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2) $(PATCH50)
	$(std_build)
	cp $(SRC)/{$(PATCH1),$(PATCH2),$(PATCH50)} $(LFSSRC)/

compile-stage2:
ifeq ($(LFS-ARCH),x86)
	patch -Np1 -i ../$(PATCH1)
endif
	patch -Np1 -i ../$(PATCH2)
	patch -Np1 -i ../$(PATCH50)
	chmod +x tests/sort/sort-mb-tests
	sed -i 's/_LEN 6/_LEN 20/' src/who.c
	./configure --prefix=/usr
	make $(PM)
	make install
	$(WD)/bin/mv /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
	$(WD)/bin/mv /usr/bin/{false,hostname,ln,ls,mkdir,mknod,mv,pwd,rm} /bin
	mv /usr/bin/{rmdir,stty,sync,true,uname} /bin
	mv /usr/bin/chroot /usr/sbin
	mv /usr/bin/{head,sleep} /bin
	mv /bin/uname /bin/uname.real
	install -m 755 ${ROOT}/uname/uname /bin/

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
