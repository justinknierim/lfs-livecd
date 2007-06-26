# Linux Kernel Makefile

NM= linux
VRS= 2.6.21.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
SHA-$(FILE)= f6e5507bf9d46563a845edfa174ac22bfa2f8896

PATCH3= tulip-is-not-a-proper-driver-for-dm910x.patch

FILE1= ati-driver-installer-8.38.6-x86.x86_64.run
URL-$(FILE1)= http://www2.ati.com/drivers/linux/$(FILE1)
SHA-$(FILE1)= a4320c6d3c6716740971c18bbd5e62b0b452cc67

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH3)
	mkdir -p /boot/isolinux
	make mrproper
	cp ../config.x86 .config
	make
	make modules_install
	cp -v arch/i386/boot/bzImage /boot/isolinux/linux
	sed 's/VERSION/$(VRS)/' ../fakes-for-fglrx/uname.in >../fakes-for-fglrx/uname
	chmod 755 ../fakes-for-fglrx/uname
	PATH=$$PWD/../fakes-for-fglrx:$$PATH sh ../$(FILE1) --buildpkg Slackware/All
	mv *.tgz /drivers
	cd .. ; ./debian-style-headers.sh $(DIR)

clean:
	-rm -rf $(DIR)
	-rm fakes-for-fglrx/uname

.PHONY: clean chroot compile-stage2
