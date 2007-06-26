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
	'cd $(ROOT) && make ch-$(NM)64 $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH3)
	make mrproper
	cp ../config.x86_64 .config
	PATH=$$PATH:$(WD)/bin make ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu-
	PATH=$$PATH:$(WD)/bin make modules_install ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu-
	sed 's/VERSION/$(VRS)/' ../fakes-for-fglrx/uname.in >../fakes-for-fglrx/uname
	chmod 755 ../fakes-for-fglrx/uname
	PATH=$$PWD/../fakes-for-fglrx:$$PATH sh ../$(FILE1) --buildpkg Slackware/Only_Module
	mv *.tgz /drivers
	rm /lib/modules/*-64bit/{source,build}
	cp -v arch/x86_64/boot/bzImage /boot/isolinux/linux64

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
