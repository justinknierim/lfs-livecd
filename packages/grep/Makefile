# Grep Makefile

# Do not update this package before RedHat! Some of the fixes are scheduled
# for grep-2.5.3, not 2.5.2

NM= grep
VRS= 2.5.1a
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 2cd082775d30be463c0ac674a00595eb56fda22e

PATCH50= $(DIR)-redhat_fixes-2.patch
URL-$(PATCH50)= $(HTTP)/$(NM)/$(PATCH50)
SHA-$(PATCH50)= 6f7f1623d1909f07dc08a8a16a24cbce6be8dfc5

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build) # See the scripts/functions file for functions like this
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
	./configure --prefix=$(WD) --disable-perl-regexp
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH50)
	$(std_build)
	cp $(SRC)/$(PATCH50) $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH50)
	chmod +x tests/fmbtest.sh
	./configure --prefix=/usr --bindir=/bin
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
