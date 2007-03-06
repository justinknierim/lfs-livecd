# taglib Makefile

NM= taglib
VRS= 1.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://developer.kde.org/~wheeler/files/src/$(FILE)
SHA-$(FILE)= 9830aed2e8d4e0d5da399e2e6b0c5d5db3a0c270

FILE1= taglib-csa3.tar.bz2
URL-$(FILE1)= http://easynews.dl.sourceforge.net/sourceforge/rusxmms/$(FILE1)
SHA-$(FILE1)= e6bb57805b4d16ab55fc04f2c85940db981f7aae

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	$(std_build)

compile-stage2:
	unpack ../$(FILE1)
	patch -Np1 -i taglib/taglib-ds-rcc.patch
	sed -i -e 's/\*2\.5\*/\*2\.6\*/g' -e 's/\*1\.7\*/\*1\.10\*/g' admin/cvs.sh
	make -f admin/Makefile.common cvs
	./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
