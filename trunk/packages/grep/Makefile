# Grep Makefile

NM= grep
VRS= 2.5.1a
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 2cd082775d30be463c0ac674a00595eb56fda22e

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build) # See the scripts/functions file for functions like this
	cp $(SRC)/$(FILE) $(LFSSRC) # Copy LFS-Base packages to safe location

compile-stage1:
	./configure --prefix=$(WD) --disable-perl-regexp
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) 
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --bindir=/bin
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
