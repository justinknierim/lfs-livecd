# Gzip Makefile

NM= gzip
VRS= 1.3.12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/gzip/$(FILE)
SHA-$(FILE)= 264e82876f201d9576626fbb1e0e9fe458efe9b9

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
