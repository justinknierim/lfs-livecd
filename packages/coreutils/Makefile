# Coreutils Makefile

NM= coreutils
VRS= 5.2.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 1028755ae0fa9be840576e4837004cf5a9981c45

PATCH1= $(DIR)-uname-2.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 15e872e94319b29c3db4e9454d8d87ff3d51999b

PATCH2= $(DIR)-suppress_uptime_kill_su-1.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 29b8d86879d6e654642b51b86766c7b8b2c53066

PATCH3= $(DIR)-echo_posix-1.patch
URL-$(PATCH3)= $(HTTP)/$(NM)/$(PATCH3)
SHA-$(PATCH3)= b160e29015f0f9f252c948010fbb40d48ce0009a

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
ifndef CROSS
	DEFAULT_POSIX2_VERSION=199209 ./configure --prefix=$(WD)
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

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2) $(PATCH3)
	$(std_build)
	cp $(SRC)/{$(PATCH1),$(PATCH2),$(PATCH3)} $(LFSSRC)/

compile-stage2:
ifeq ($(LFS-ARCH),x86)
	patch -Np1 -i ../$(PATCH1)
endif
ifeq ($(LFS-ARCH),x86_64)
	patch -Np1 -i ../$(PATCH1)
endif
	patch -Np1 -i ../$(PATCH2)
	patch -Np1 -i ../$(PATCH3)
ifndef CROSS
	DEFAULT_POSIX2_VERSION=199209 ./configure --prefix=/usr
else
	CC="gcc ${BUILD64}" DEFAULT_POSIX2_VERSION=199209 \
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
