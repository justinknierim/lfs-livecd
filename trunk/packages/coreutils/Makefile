# Coreutils Makefile

NM= coreutils
VRS= 5.93
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 56d983bfb20d04ff298677e7e795956f0d44ea6f

PATCH1= $(DIR)-uname-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 42cc795e56b96994a4dc9e8f2a8dd72b6a25665f

PATCH2= $(DIR)-suppress_uptime_kill_su-1.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 6a0098315fa9b7cb80d17dd1b146ac91fa187606

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
ifndef CROSS
	./configure --prefix=$(WD)
else
	echo "utils_cv_sys_open_max=1024" >> config.cache
	DEFAULT_POSIX2_VERSION=199209 CC="$${CC} $(64FLAGS)" \
	 ./configure --prefix=$(WD) --cache-file=config.cache \
	 --build=$(LFS_HOST) --target=$(LFS_TARGET)
endif
	make $(PM)
	make install
ifndef CROSS
	mv ${WD}/bin/uname ${WD}/bin/uname.real 
	install -m 755 ${MP}${ROOT}/uname/uname ${WD}/bin/
endif

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2) 
	$(std_build)
	cp $(SRC)/{$(PATCH1),$(PATCH2)} $(LFSSRC)/

compile-stage2:
ifeq ($(LFS-ARCH),x86)
	patch -Np1 -i ../$(PATCH1)
endif
ifeq ($(LFS-ARCH),x86_64)
	patch -Np1 -i ../$(PATCH1)
endif
	patch -Np1 -i ../$(PATCH2)
ifndef CROSS
	./configure --prefix=/usr
else
	CC="gcc $(64FLAGS)" DEFAULT_POSIX2_VERSION=199209 \
	 ./configure --prefix=/usr
endif
	make $(PM)
	make install
	$(WD)/bin/mv /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
	$(WD)/bin/mv /usr/bin/{false,hostname,ln,ls,mkdir,mknod,mv,pwd,rm} /bin
	mv /usr/bin/{rmdir,stty,sync,true,uname} /bin
	mv /usr/bin/chroot /usr/sbin
	mv /usr/bin/{head,sleep} /bin
ifndef CROSS
	mv /bin/uname /bin/uname.real
	install -m 755 ${ROOT}/uname/uname /bin/
endif

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
