# Linux Kernel Makefile

NM= linux
VRS= 2.6.22.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
SHA-$(FILE)= 7aa119f88768c3070f96a48562ea68b2ecd8a2ef

PATCH1= reiser4-for-2.6.22-2.patch.gz
URL-$(PATCH1)= ftp://ftp.namesys.com/pub/reiser4-for-2.6/2.6.22/$(PATCH1)
SHA-$(PATCH1)= a49f8a6d9851915c31f4c44e00519e0e4d2461c7

PATCH3= tulip-is-not-a-proper-driver-for-dm910x.patch

FILE1= ati-driver-installer-8.38.6-x86.x86_64.run
URL-$(FILE1)= http://www2.ati.com/drivers/linux/$(FILE1)
SHA-$(FILE1)= a4320c6d3c6716740971c18bbd5e62b0b452cc67

DIR2= NVIDIA-Linux-x86_64-100.14.11-pkg0
FILE2= $(DIR2).run
URL-$(FILE2)= http://us.download.nvidia.com/XFree86/Linux-x86_64/100.14.11/$(FILE2)
SHA-$(FILE2)= 11c4f7ab736262e20db937ec410de3511e3e6aad

DIR3= NVIDIA-Linux-x86_64-1.0-9639-pkg0
FILE3= $(DIR3).run
URL-$(FILE3)= http://us.download.nvidia.com/XFree86/Linux-x86_64/1.0-9639/$(FILE3)
SHA-$(FILE3)= 6294d421131b9dc4514634ecde171869f589dae3

DIR4= NVIDIA-Linux-x86_64-1.0-7185-pkg0
FILE4= $(DIR4).run
URL-$(FILE4)= http://us.download.nvidia.com/XFree86/Linux-x86_64/1.0-7185/$(FILE4)
SHA-$(FILE4)= ffe1eb012707d5bffbe39756be54cb687b4ef498

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM)64 $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1) $(FILE2) $(FILE3) $(FILE4) $(PATCH1)
	$(std_build)

compile-stage2:
	zcat ../$(PATCH1) | patch -Np1
	patch -Np1 -i ../$(PATCH3)
	make mrproper
	cp ../config.x86_64 .config
	# Hack for fglrx
	touch include/linux/ioctl32.h
	PATH=$$PATH:$(WD)/bin make ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu-
	PATH=$$PATH:$(WD)/bin make modules_install ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu-
	sed 's/VERSION/$(VRS)/' ../fakes-for-fglrx/uname.in >../fakes-for-fglrx/uname
	sed 's/VERSION/$(VRS)/' ../fakes-for-fglrx/cat.in >../fakes-for-fglrx/cat
	chmod 755 ../fakes-for-fglrx/{uname,cat}
	PATH=$$PWD/../fakes-for-fglrx:$$PATH sh ../$(FILE1) --buildpkg Slackware/Only_Module
	for a in $(DIR2) $(DIR3) $(DIR4) ; do \
	    sh ../$$a.run -x ; ../build-nvidia-driver $$a $(VRS)-64bit ; done
	mv *.tgz /drivers
	rm /lib/modules/*-64bit/{source,build}
	cp -v arch/x86_64/boot/bzImage /boot/isolinux/linux64

clean:
	-rm -rf $(DIR)
	-rm -f fakes-for-fglrx/{uname,cat}

.PHONY: clean chroot compile-stage2
