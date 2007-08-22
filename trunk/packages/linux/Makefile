# Linux Kernel Makefile

NM= linux
VRS= 2.6.22.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
SHA-$(FILE)= cc729d89add08c6fd7b91e440eda459b9c284950

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

DIR8= madwifi-0.9.3.2
FILE8= $(DIR8).tar.bz2
URL-$(FILE8)= http://easynews.dl.sourceforge.net/sourceforge/madwifi/$(FILE8)
SHA-$(FILE8)= ccd8f4ba267df75ca002d8dbf66b09347e1bc0b6

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1) $(FILE2) $(FILE3) $(FILE4) $(FILE5) $(FILE6) $(FILE7) $(FILE8) $(PATCH1)
	$(std_build)

compile-stage2:
	tar xf ../$(FILE5) ; cd $(DIR5) ; make KSRC=.. patch_kernel
	tar xf ../$(FILE6) ; cd $(DIR6) ; echo "Y" | make KSRC=.. patch_kernel
	zcat ../$(PATCH1) | patch -Np1
	patch -Np1 -i ../$(PATCH3)
	install -d /boot/isolinux
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
	tar xf ../$(FILE7) ; cd $(DIR7) ; cp ../../config.rt2x00 config ; \
	    sed -i '/depmod/d' Makefile ; \
	    patch -Np0 -i ../../$(PATCH2) ; make KERNDIR=`pwd`/.. ; \
	    make KERNDIR=`pwd`/.. install
	tar xf ../$(FILE8) ; cd $(DIR8) ; \
	    make BINDIR=/usr/bin MANDIR=/usr/share/man KERNELPATH=`pwd`/.. ; \
	    make BINDIR=/usr/bin MANDIR=/usr/share/man KERNELPATH=`pwd`/.. DESTDIR=`pwd`/DESTDIR-modules install-modules ; \
	    make BINDIR=/usr/bin MANDIR=/usr/share/man KERNELPATH=`pwd`/.. DESTDIR=`pwd`/DESTDIR-tools install-tools ; \
	    cd DESTDIR-modules ; tar zcvf ../../$(DIR8)-kernel-$(VRS).tgz . ; cd .. ; \
	    cd DESTDIR-tools ; tar zcvf ../../$(DIR8)-tools.tgz .
	mv *.tgz /drivers
	cd .. ; ./debian-style-headers.sh $(DIR)

clean:
	-rm -rf $(DIR)
	-rm fakes-for-fglrx/{uname,cat}

.PHONY: clean chroot compile-stage2
