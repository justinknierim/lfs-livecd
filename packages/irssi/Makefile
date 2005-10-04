# irssi Makefile

NM= irssi
VRS= 0.8.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://irssi.org/files/$(FILE)
SHA-$(FILE)= 57799a1e99ac5f6694eb6fd049d39a4e2e51f576

PATCH1= $(DIR)-gcc4_fixes-1.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr
	make $(PM)
	make install
	cp -ra $(ROOT)/root/.irssi /root

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
