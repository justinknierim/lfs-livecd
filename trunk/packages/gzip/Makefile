# Gzip Makefile

NM= gzip
VRS= 1.3.11
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= ftp://alpha.gnu.org/gnu/gzip/$(FILE)
SHA-$(FILE)= e514095796d83b7bc1e6507ee6a1e32fe76cff41

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build) 

compile-stage1:
	./configure --prefix=$(WD)
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --bindir=/bin
	make
	make install
	mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
	mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
