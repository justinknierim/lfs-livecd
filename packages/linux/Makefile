# Linux Kernel Makefile

NM= linux
VRS= 2.6.22.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
SHA-$(FILE)= 7aa119f88768c3070f96a48562ea68b2ecd8a2ef

PATCH3= tulip-is-not-a-proper-driver-for-dm910x.patch

FILE1= ati-driver-installer-8.38.6-x86.x86_64.run
URL-$(FILE1)= http://www2.ati.com/drivers/linux/$(FILE1)
SHA-$(FILE1)= a4320c6d3c6716740971c18bbd5e62b0b452cc67

DIR2= NVIDIA-Linux-x86-100.14.11-pkg0
FILE2= $(DIR2).run
URL-$(FILE2)= http://us.download.nvidia.com/XFree86/Linux-x86/100.14.11/$(FILE2)
SHA-$(FILE2)= 95e101a5b1567bbcce91ce18f48e19d2c344ff05

DIR3= NVIDIA-Linux-x86-1.0-9639-pkg0
FILE3= $(DIR3).run
URL-$(FILE3)= http://us.download.nvidia.com/XFree86/Linux-x86/1.0-9639/$(FILE3)
SHA-$(FILE3)= 07b879712fb8b39ad3a11f4d5e0f16c95539e2d3

DIR4= NVIDIA-Linux-x86-1.0-7185-pkg0
FILE4= $(DIR4).run
URL-$(FILE4)= http://us.download.nvidia.com/XFree86/Linux-x86/1.0-7185/$(FILE4)
SHA-$(FILE4)= 35593bee1499aaa429d9572a0c49f2fd137d0d22

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1) $(FILE2) $(FILE3) $(FILE4)
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
	sed 's/VERSION/$(VRS)/' ../fakes-for-fglrx/cat.in >../fakes-for-fglrx/cat
	chmod 755 ../fakes-for-fglrx/{uname,cat}
	PATH=$$PWD/../fakes-for-fglrx:$$PATH sh ../$(FILE1) --buildpkg Slackware/All
	for a in $(DIR2) $(DIR3) $(DIR4) ; do \
	    sh ../$$a.run -x ; ../build-nvidia-driver $$a $(VRS) ; done
	mv *.tgz /drivers
	cd .. ; ./debian-style-headers.sh $(DIR)

clean:
	-rm -rf $(DIR)
	-rm fakes-for-fglrx/{uname,cat}

.PHONY: clean chroot compile-stage2
