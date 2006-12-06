# Gzip Makefile

NM= gzip
VRS= 1.3.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 843272609b9bff1bdf2770a28d498d6519901e73

PATCH1= $(DIR)-security_fixes-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 3ab15ed9fa2b8b3e26b6f8d878f5cf43f822abca

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build) 
	cp $(SRC)/$(FILE) $(LFSSRC) 

compile-stage1:
	./configure --prefix=$(WD)
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/$(PATCH1) $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	sed -i 's/tail +/tail -n +/' gzexe.in
	./configure --prefix=/usr
	sed -i 's@"BINDIR"@/bin@g' gzexe.in
	make $(PM)
	make install
	mv -v /usr/bin/gzip /bin
	rm -v /usr/bin/{gunzip,zcat}
	ln -sfv gzip /bin/gunzip
	ln -sfv gzip /bin/zcat
	ln -sfv gzip /bin/compress
	ln -sfv gunzip /bin/uncompress

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
