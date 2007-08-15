# Linux Kernel Makefile

NM= linux
VRS= 2.6.22.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
SHA-$(FILE)= e2606e42a3b40e16f65f750f1dd7cf6a580ea71a

PATCH1= reiser4-for-2.6.22-2.patch.gz
URL-$(PATCH1)= ftp://ftp.namesys.com/pub/reiser4-for-2.6/2.6.22/$(PATCH1)
SHA-$(PATCH1)= a49f8a6d9851915c31f4c44e00519e0e4d2461c7

# Undoes some upstream changes that are needed for linux-2.6.23-rcX
# but break the build with 2.6.22
PATCH2= rt2x00-fixes-1.patch

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

DIR5= mac80211-9.0.4
FILE5= $(DIR5).tgz
URL-$(FILE5)= http://intellinuxwireless.org/mac80211/downloads/$(FILE5)
SHA-$(FILE5)= c15acff74a7c736cdb997546083f1e34278c6387

DIR6= iwlwifi-1.0.0-1
FILE6= $(DIR6).tgz
URL-$(FILE6)= http://intellinuxwireless.org/iwlwifi/downloads/$(FILE6)
SHA-$(FILE6)= 879a636b63cd1c8aebc8bc1a6205656b491107bb

DIR7= rt2x00-cvs-2007081406
FILE7= $(DIR7).tar.gz
# Originally from http://rt2x00.serialmonkey.com/rt2x00-cvs-daily.tar.gz
URL-$(FILE7)= http://www.linuxfromscratch.org/~alexander/$(FILE7)
SHA-$(FILE7)= 3eba4dc8e08ce256280adff492b541bda9c0198b

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM)64 $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1) $(FILE2) $(FILE3) $(FILE4) $(FILE5) $(FILE6) $(FILE7) $(PATCH1)
	$(std_build)

compile-stage2:
	tar xf ../$(FILE5) ; cd $(DIR5) ; make KSRC=.. patch_kernel
	tar xf ../$(FILE6) ; cd $(DIR6) ; echo "Y" | make KSRC=.. patch_kernel
	zcat ../$(PATCH1) | patch -Np1
	patch -Np1 -i ../$(PATCH3)
	install -d /boot/isolinux
	make mrproper
	cp ../config.x86_64 .config
	# Hack for fglrx
	touch include/linux/ioctl32.h
ifeq ($(CD_ARCH),x86)
	PATH=$$PATH:$(WD)/bin make ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu-
	PATH=$$PATH:$(WD)/bin make modules_install ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu-
	sed 's/VERSION/$(VRS)/' ../fakes-for-fglrx/uname.in >../fakes-for-fglrx/uname
	sed 's/VERSION/$(VRS)/' ../fakes-for-fglrx/cat.in >../fakes-for-fglrx/cat
	chmod 755 ../fakes-for-fglrx/{uname,cat}
	PATH=$$PWD/../fakes-for-fglrx:$$PATH sh ../$(FILE1) --buildpkg Slackware/Only_Module
	for a in $(DIR2) $(DIR3) $(DIR4) ; do \
	    sh ../$$a.run -x ; ../build-nvidia-driver $$a $(VRS)-64bit ; done
	mv *.tgz /drivers
	tar xf ../$(FILE7) ; cd $(DIR7) ; cp ../../config.rt2x00 config ; \
	    sed -i '/depmod/d' Makefile ; \
	    patch -Np0 -i ../../$(PATCH2) ; \
	    PATH=$$PATH:$(WD)/bin make KERNDIR=`pwd`/.. ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu- ; \
	    PATH=$$PATH:$(WD)/bin make KERNDIR=`pwd`/.. ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu- install
	rm /lib/modules/*-64bit/{source,build}
	cp -v arch/x86_64/boot/bzImage /boot/isolinux/linux64
endif
ifeq ($(CD_ARCH),x86_64)
	make
	make modules_install
	sed 's/VERSION/$(VRS)/' ../fakes-for-fglrx/uname.in >../fakes-for-fglrx/uname
	sed 's/VERSION/$(VRS)/' ../fakes-for-fglrx/cat.in >../fakes-for-fglrx/cat
	chmod 755 ../fakes-for-fglrx/{uname,cat}
	PATH=$$PWD/../fakes-for-fglrx:$$PATH sh ../$(FILE1) --buildpkg Slackware/All
	for a in $(DIR2) $(DIR3) $(DIR4) ; do \
	    sh ../$$a.run -x ; ../build-nvidia-driver.native $$a $(VRS)-64bit ; done
	mv *.tgz /drivers
	tar xf ../$(FILE7) ; cd $(DIR7) ; cp ../../config.rt2x00 config ; \
	    sed -i '/depmod/d' Makefile ; \
	    patch -Np0 -i ../../$(PATCH2) ; \
	    make KERNDIR=`pwd`/.. ; make KERNDIR=`pwd`/.. install
	cp -v arch/x86_64/boot/bzImage /boot/isolinux/linux
endif

clean:
	-rm -rf $(DIR)
	-rm -f fakes-for-fglrx/{uname,cat}

.PHONY: clean chroot compile-stage2
