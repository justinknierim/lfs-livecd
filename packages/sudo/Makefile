# sudo Makefile

NM= sudo
VRS= 1.6.8p12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= a79631e9e1c0d0d3f2aa88ae685628e5fde61982

PATCH1= $(DIR)-envvar_fix-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 08d7579c7ca96a330e5eb7108b0d40bf689a751f

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --libexecdir=/usr/lib \
	 --enable-noargs-shell --with-ignore-dot --with-all-insults \
	 --enable-shell-sets-home
	make
	rm -f /etc/sudoers
	echo 'jhalfs    ALL=(ALL) NOPASSWD:ALL' >>sudoers
	env -i PATH=$$PATH make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
