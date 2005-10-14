# Gzip Makefile

NM= gzip
VRS= 1.3.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= c860a851959d77e45ff153183b43723dd5a5c542

PATCH1= $(DIR)-security_fixes-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 3ab15ed9fa2b8b3e26b6f8d878f5cf43f822abca

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build) 
	cp $(SRC)/$(FILE) $(LFSSRC) 

compile-stage1:
ifndef CROSS
	./configure --prefix=$(WD)
else
	cp configure{,.bak}
	sed "s@nm conftest@$(LFS_TARGET)-&@" configure.bak > configure
	CC="$${CC} $(64FLAGS)" ./configure --prefix=$(WD) \
	 --host=$(LFS_TARGET)
endif
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
ifndef CROSS
	./configure --prefix=/usr
else
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr
endif
	sed -i 's@"BINDIR"@/bin@g' gzexe.in
	make $(PM)
	make install
	mv /usr/bin/gzip /bin
	rm /usr/bin/{gunzip,zcat}
	ln -sf gzip /bin/gunzip
	ln -sf gzip /bin/zcat
	ln -sf gzip /bin/compress
	ln -sf gunzip /bin/uncompress

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
