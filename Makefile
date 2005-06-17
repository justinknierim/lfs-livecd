#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Makefile for automating the LFS LiveCD build
#
# Written by Jeremy Huntwork, 2004-1-27
#
# jhuntwork@linuxfromscratch.org
#
# Version for x86 arch using LFS 6.1
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Edit this line to match the mount-point of the
# partition you'll be using to build the cd.
export MP := /mnt/lfs

# Timezone, obviously ;)
export timezone := GMT

# Page size for groff
export pagesize := letter

# Top-level of these Makefiles. Edit this if you've named
# this directory differently.
# (The beginning / is necessary - leave it in place - this is *not*
# an absolute file path.)
export ROOT := /lfs-livecd

# Ftp server for the lfs-base packages
export FTP := ftp://ftp.lfs-matrix.net/pub/lfs/lfs-packages/conglomeration

# Don't edit these!
export VERSION=x86-6.1-1-pre4
export HOSTNAME := lfslivecd
export WD := /tools
export SRC := /sources
export PKG := packages
export MKTREE := $(MP)$(ROOT)
export CFLAGS := -Os -s -march=i486
export CXXFLAGS := -Os -s -march=i486
export CHOST := i486-pc-linux-gnu
export lfsenv := exec env -i HOME=$$HOME CFLAGS='$(CFLAGS)' CXXFLAGS='$(CXXFLAGS)' LFS=$(MP) LC_ALL=POSIX PATH=$(WD)/bin:/bin:/usr/bin /bin/bash -c

export lfsbash := set +h && umask 022 && cd $(MKTREE)

export chenv1 := $(WD)/bin/env -i HOME=/root CFLAGS='$(CFLAGS)' CXXFLAGS='$(CXXFLAGS)' TERM=$(TERM) PS1='\u:\w\$$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin:$(WD)/bin $(WD)/bin/bash -c

export chenv2 := $(WD)/bin/env -i HOME=/root CFLGAS='$(CFLAGS)' CXXFLAGS='$(CXXFLAGS)' TERM=$(TERM) PS1='\u:\w\$$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin:$(WD)/bin /bin/bash -c

export chenv3 := /usr/bin/env -i HOME=/root CFLAGS='$(CFLAGS)' TERM=$(TERM) PS1='\u:\w\$$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/X11R6/bin INPUTRC=/etc/inputrc XML_CATALOG_FILES="/usr/share/xml/docbook/xsl-stylesheets-1.68.1/catalog.xml /etc/xml/catalog" PKG_CONFIG_PATH=/usr/X11R6/lib/pkgconfig /bin/bash -c

export chenvstrip := $(WD)/bin/env -i HOME=/root TERM=$(TERM) PS1='\u:\w\$$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin $(WD)/bin/bash -c

export chbash1 := SHELL=$(WD)/bin/bash
export chbash2 := SHELL=/bin/bash
export WHICH= $(WD)/bin/which
export WGET= wget --passive-ftp

export KVERS= 2.6.11.10

FTPGET= $(WD)/bin/ftpget
WGET_V= 1.9.1

# TARGETS
#=======================================================================


# The make build starts and ends here, first building the dependency targets,
# lfs-base, extend-lfs and iso, then it echos a notice that it's finished. :)

all: lfs-base extend-lfs iso
	@echo "The livecd, $(MKTREE)/lfslivecd-$(VERSION).iso, is ready!"

# This target builds just a base LFS system, minus the kernel and bootscripts

lfs-base:
	@if [ `whoami` != "root" ] ; then echo "You must be logged in as root." \
	 && exit 1 ; fi
	@echo "==============================================================="
	@echo " Before you begin building the LiveCD image, please ensure "
	@echo " that the following is true: "
	@echo ""
	@echo " 1) Your running kernel is the same version as the target "
	@echo "    kernel for the cd."
	@echo ""
	@echo " 2) You have an active internet connection."
	@echo "==============================================================="
	@echo ""
	@echo -n -e "Countdown to commence building:"
	@for i in 10 9 8 7 6 5 4 3 2 1 ; do echo -n -e " $$i" && sleep 1 ; done
	@echo ""
	@-mkdir -p $(MP)$(WD)/bin; ln -s $(MP)$(WD) /
	@if [ ! -d $(MP)$(SRC) ] ; then mkdir $(MP)$(SRC) ; fi
	@-ln -sf $(MP)$(SRC) /
	@-ln -s $(MP)$(ROOT) /
	@make lfsuser
	@-chown -R lfs $(WD) $(MP)$(WD) $(WD)/bin $(SRC) $(MP)$(SRC) $(MKTREE)
	@echo ""
	@echo "=========================="
	@echo " Building LFS Base System"
	@echo "=========================="
	@echo ""
	@make unamemod
	@cp $(ROOT)/scripts/unpack $(WD)/bin
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) tools'"
	@if [ ! -f $(PKG)/wget/.pass2 ] ; then make lfs-rm-wget && make lfs-wget ; fi
	@touch $(PKG)/wget/.pass2
	@make prep-chroot
	@-mkdir $(MP)/bin
	@if [ ! -f $(MP)/bin/bash ] ; then if [ ! -d $(MP) ] ; then mkdir $(MP)/bin ; fi ; ln -s ${WD}/bin/bash ${MP}/bin/bash ; fi
	@chroot "$(MP)" $(chenv1) 'set +h && chown -R 0:0 $(WD) $(SRC) $(ROOT) && cd $(ROOT) && make pre-bash $(chbash1)'
	@chroot "$(MP)" $(chenv2) 'set +h && cd $(ROOT) && make post-bash $(chbash2)'

extend-lfs:
	@cp $(WD)/bin/which $(MP)/usr/bin
	@cp $(ROOT)/scripts/unpack $(MP)/bin
	@chroot "$(MP)" $(chenv3) 'set +h && cd $(ROOT) && make blfs $(chbash2)'
	#@chroot "$(MP)" $(chenvstrip) 'set +h && cd $(ROOT) && make ch-strip'
	@make unloadmodule
	@make unmount

lfsuser:
	@-groupadd lfs
	@-useradd -s /bin/bash -g lfs -m -k /dev/null lfs
	@touch lfsuser

pre-which:
	@echo "#!/bin/sh" > $(WHICH)
	@echo 'type -pa "$$@" | head -n 1 ; exit $${PIPESTATUS[0]}' >> $(WHICH)
	@chmod 755 $(WHICH)

pre-wget: 
	@if [ ! -f /tools/bin/ftpget ] ; then echo "#!/bin/sh" > $(FTPGET) && \
					      echo "ftp -n << END" >> $(FTPGET) && \
					      echo "open ftp.gnu.org" >> $(FTPGET) && \
					      echo "user anonymous" >> $(FTPGET) && \
				 	      echo "passive" >> $(FTPGET) && \
					      echo "binary" >> $(FTPGET) && \
					      echo "cd gnu/wget" >> $(FTPGET) && \
					      echo "get wget-$(WGET_V).tar.gz" >> $(FTPGET) && \
					      echo "bye" >> $(FTPGET) && \
					      echo "END" >> $(FTPGET) && \
					      chmod 755 $(FTPGET) ; fi
	@$(MAKE) -C $(PKG)/wget prebuild

unamemod:
	@if [ ! -d ${WD}/bin ] ; then mkdir ${WD}/bin ; fi
	@install -m 755 uname/uname ${WD}/bin/
	@touch unamemod

tools:  pre-which pre-wget lfs-binutils-pass1-scpt lfs-gcc-pass1-scpt lfs-linux-libc-headers-scpt lfs-glibc-scpt \
	lfs-adjust-toolchain-scpt lfs-tcl-scpt lfs-expect-scpt lfs-dejagnu-scpt lfs-gcc-pass2-scpt lfs-binutils-pass2-scpt \
	lfs-gawk-scpt lfs-coreutils-scpt lfs-bzip2-scpt lfs-gzip-scpt lfs-diffutils-scpt lfs-findutils-scpt lfs-make-scpt \
	lfs-grep-scpt lfs-sed-scpt lfs-gettext-scpt lfs-ncurses-scpt lfs-patch-scpt lfs-tar-scpt lfs-texinfo-scpt \
	lfs-bash-scpt lfs-m4-scpt lfs-bison-scpt lfs-flex-scpt lfs-util-linux-scpt lfs-perl-scpt lfs-strip-scpt
	@cp /etc/resolv.conf $(WD)/etc

prep-chroot:
	@-mkdir -p $(MP)/{proc,sys}
	@-mount -t proc proc $(MP)/proc
	@-mount -t sysfs sysfs $(MP)/sys
	@-mount -f -t ramfs ramfs $(MP)/dev
	@-mount -f -t tmpfs tmpfs $(MP)/dev/shm
	@-mount -f -t devpts -o gid=4,mode=620 devpts $(MP)/dev/pts

pre-bash: createdirs createfiles popdev ch-linux-libc-headers ch-man-pages ch-glibc ch-re-adjust-toolchain \
	ch-binutils ch-gcc ch-coreutils ch-zlib ch-mktemp ch-iana-etc ch-findutils ch-gawk ch-sharutils ch-gpm ch-ncurses \
	ch-readline ch-vim ch-m4 ch-bison ch-less ch-groff ch-sed ch-flex ch-gettext ch-inetutils \
	ch-iproute2 ch-perl ch-texinfo ch-autoconf ch-automake ch-bash

post-bash: ch-file ch-libtool ch-bzip2 ch-diffutils ch-kbd ch-e2fsprogs ch-grep ch-grub ch-gzip \
	ch-hotplug ch-man ch-make ch-module-init-tools ch-patch ch-procps ch-psmisc ch-shadow \
	ch-sysklogd ch-sysvinit ch-tar ch-udev ch-util-linux ch-environment

blfs: ch-openssl ch-wget ch-reiserfsprogs ch-xfsprogs ch-slang ch-nano ch-joe ch-screen ch-curl ch-zip \
	ch-unzip ch-lynx ch-libxml2 ch-expat ch-subversion ch-lfs-bootscripts ch-docbook-xml ch-libxslt \
	ch-docbook-xsl ch-html_tidy ch-LFS-BOOK ch-libpng ch-freetype ch-fontconfig ch-Xorg ch-freefont ch-inputattach \
	ch-fonts-dejavu ch-update-fontsdir ch-libjpeg ch-libtiff ch-links ch-openssh ch-pkgconfig ch-glib2 \
	ch-libungif ch-imlib2 ch-pango ch-atk ch-gtk2 ch-cvs ch-popt ch-samba ch-libIDL ch-firefox ch-thunderbird ch-startup-notification ch-gvim \
	ch-xfce ch-lua ch-ion ch-irssi ch-xchat ch-tcpwrappers ch-portmap ch-nfs-utils ch-traceroute ch-dialog \
	ch-ncftp ch-pciutils ch-nALFS ch-device-mapper ch-LVM2 ch-dhcpcd ch-distcc ch-ppp ch-rp-pppoe ch-libaal \
	ch-reiser4progs ch-squashfs ch-cpio ch-db ch-postfix ch-mutt ch-msmtp ch-slrn ch-raidtools ch-linux ch-klibc ch-unionfs \
	ch-initramfs ch-cdrtools ch-blfs-bootscripts ch-syslinux

# Rules for building tools/stage1
# These can be called individually, if necessary

lfs-wget: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) pre-wget'"

lfs-rm-wget: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) &&rm $(WD)/bin/wget'"
	
lfs-binutils-pass1: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-binutils-pass1-scpt'"

lfs-gcc-pass1: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-gcc-pass1-scpt'"

lfs-linux-libc-headers: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-linux-libc-headers-scpt'"

lfs-glibc: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-glibc-scpt'"

lfs-adjust-toolchain: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-adjust-toolchain-scpt'"

lfs-tcl: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-tcl-scpt'"

lfs-expect: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-expect-scpt'"

lfs-dejagnu: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-dejagnu-scpt'"

lfs-gcc-pass2: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-gcc-pass2-scpt'"

lfs-binutils-pass2: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-binutils-pass2-scpt'"

lfs-gawk: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-gawk-scpt'"

lfs-coreutils: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-coreutils-scpt'"

lfs-bzip2: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-bzip2-scpt'"

lfs-gzip: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-gzip-scpt'"

lfs-diffutils: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-diffutils-scpt'"

lfs-findutils: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-findutils-scpt'"

lfs-make: uanmemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-make-scpt'"

lfs-grep: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-grep-scpt'"

lfs-sed: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-sed-scpt'"

lfs-gettext: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-gettext-scpt'"

lfs-ncurses: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-ncurses-scpt'"

lfs-patch: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-patch-scpt'"

lfs-tar: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-tar-scpt'"

lfs-texinfo: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-texinfo-scpt'"

lfs-bash: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-bash-scpt'"

lfs-m4: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-m4-scpt'"

lfs-bison: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-bison-scpt'"

lfs-flex: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-flex-scpt'"

lfs-util-linux: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-util-linux-scpt'"

lfs-perl: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-perl-scpt'"

lfs-strip: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-strip-scpt'"
	@touch lfs-strip

createdirs:
	@-$(WD)/bin/install -d /{bin,boot,dev,etc/opt,home,lib,mnt}
	@-$(WD)/bin/install -d /{sbin,srv,usr/local,var,opt}
	@-$(WD)/bin/install -d /root -m 0750
	@-$(WD)/bin/install -d /tmp /var/tmp -m 1777
	@-$(WD)/bin/install -d /media/{floppy,cdrom}
	@-$(WD)/bin/install -d /usr/{bin,include,lib,sbin,share,src}
	@-$(WD)/bin/ln -s share/{man,doc,info} /usr
	@-$(WD)/bin/install -d /usr/share/{doc,info,locale,man}
	@-$(WD)/bin/install -d /usr/share/{misc,terminfo,zoneinfo}
	@-$(WD)/bin/install -d /usr/share/man/man{1,2,3,4,5,6,7,8}
	@-$(WD)/bin/install -d /usr/local/{bin,etc,include,lib,sbin,share,src}
	@-$(WD)/bin/ln -s share/{man,doc,info} /usr/local
	@-$(WD)/bin/install -d /usr/local/share/{doc,info,locale,man}
	@-$(WD)/bin/install -d /usr/local/share/{misc,terminfo,zoneinfo}
	@-$(WD)/bin/install -d /usr/local/share/man/man{1,2,3,4,5,6,7,8}
	@-$(WD)/bin/install -d /var/{lock,log,mail,run,spool}
	@-$(WD)/bin/install -d /var/{opt,cache,lib/{misc,locate},local}
	@-$(WD)/bin/install -d /opt/{bin,doc,include,info}
	@-$(WD)/bin/install -d /opt/{lib,man/man{1,2,3,4,5,6,7,8}}
	@-$(WD)/bin/ln -s $(WD)/bin/{bash,cat,pwd,stty} /bin
	@-$(WD)/bin/ln -s $(WD)/bin/perl /usr/bin
	@-$(WD)/bin/ln -s $(WD)/lib/libgcc_s.so{,.1} /usr/lib
	@-$(WD)/bin/ln -s bash /bin/sh

createfiles:
	@echo "root:x:0:0:root:/root:/bin/bash" > /etc/passwd
	@echo "root:x:0:" > /etc/group
	@echo "bin:x:1:" >> /etc/group
	@echo "sys:x:2:" >> /etc/group
	@echo "kmem:x:3:" >> /etc/group
	@echo "tty:x:4:" >> /etc/group
	@echo "tape:x:5:" >> /etc/group
	@echo "daemon:x:6:" >> /etc/group
	@echo "floppy:x:7:" >> /etc/group
	@echo "disk:x:8:" >> /etc/group
	@echo "lp:x:9:" >> /etc/group
	@echo "dialout:x:10:" >> /etc/group
	@echo "audio:x:11:" >> /etc/group
	@echo "video:x:12:" >> /etc/group
	@echo "utmp:x:13:" >> /etc/group
	@echo "usb:x:14:" >> /etc/group
	@touch /var/run/utmp /var/log/{btmp,lastlog,wtmp}
	@chgrp utmp /var/run/utmp /var/log/lastlog
	@chmod 664 /var/run/utmp /var/log/lastlog
	@mv $(WD)/etc/resolv.conf /etc

popdev:
	@if [ ! -c /dev/console ] ; then mknod -m 600 /dev/console c 5 1 && \
	 mknod -m 666 /dev/null c 1 3 ; fi
	@if ! tail -n 3 /proc/mounts | grep -q "dev ramfs" ; then mount -n -t ramfs none /dev && \
	 mknod -m 662 /dev/console c 5 1 && \
	 mknod -m 666 /dev/null c 1 3 && \
	 mknod -m 666 /dev/zero c 1 5 && \
	 mknod -m 666 /dev/ptmx c 5 2 && \
	 mknod -m 666 /dev/tty c 5 0 && \
	 mknod -m 444 /dev/random c 1 8 && \
	 mknod -m 444 /dev/urandom c 1 9 && \
	 chown root:tty /dev/{console,ptmx,tty} && \
	 ln -s /proc/self/fd /dev/fd && \
	 ln -s /proc/self/fd/0 /dev/stdin && \
	 ln -s /proc/self/fd/1 /dev/stdout && \
	 ln -s /proc/self/fd/2 /dev/stderr && \
	 ln -s /proc/kcore /dev/core && \
	 mkdir /dev/pts && mkdir /dev/shm && \
	 mount -t devpts -o gid=4,mode=620 none /dev/pts && \
	 mount -t tmpfs none /dev/shm ; fi
	@if [ -f /sbin/udevstart ] ; then /sbin/udevstart ; fi

linux-libc-headers: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

man-pages: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount
	
glibc: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

re-adjust-toolchain: prep-chroot
	make -C $(PKG)/binutils chroot-re-adjust-toolchain
	make unmount

binutils: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

gcc: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

coreutils: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

zlib: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

mktemp: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

iana-etc: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

findutils: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

gawk: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

sharutils: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

ncurses: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

readline: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

vim: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

m4: prep-chroot   
	make -C $(PKG)/$@ chroot
	make unmount
	
bison: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

less: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

groff: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

sed: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

flex: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

gettext: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

inetutils: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

iproute2: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

perl: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

texinfo: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

autoconf: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

automake: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

bash: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

file: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

libtool: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

bzip2: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

diffutils: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

kbd: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

e2fsprogs: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

grep: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

grub: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

gzip: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

hotplug: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

man: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

make: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

module-init-tools: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

patch: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

procps: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

psmisc: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

shadow: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

sysklogd: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

sysvinit: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

tar: prep-chroot 
	make -C $(PKG)/$@ chroot
	make unmount

udev: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

util-linux: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount


lfs-bootscripts: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

wget: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

reiserfsprogs: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

xfsprogs: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

slang: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

nano: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

joe: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

screen: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

openssl: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

curl: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

gpm: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

zip: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

unzip: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

lynx: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

libxml2: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

expat: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

subversion: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

docbook-xml: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

libxslt: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

docbook-xsl: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

html_tidy: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

LFS-BOOK: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

libpng: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

freetype: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

fontconfig: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

Xorg: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

freefont: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

fonts-dejavu: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

libjpeg: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

libtiff: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

links: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

openssh: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

pkgconfig: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

glib2: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

libungif: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

imlib2: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

pango: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

atk: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

gtk2: prep-chroot
	make -C $(PKG)/gtk+2 chroot
	make unmount

cvs: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

libIDL: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

firefox: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

thunderbird: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

startup-notification: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

gvim: prep-chroot
	make -C $(PKG)/vim chroot3
	make unmount

xfce: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

lua: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

ion: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

irssi: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

xchat: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

samba: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

tcpwrappers: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

portmap: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

nfs-utils: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

traceroute: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

dialog: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

ncftp: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

pciutils: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

nALFS: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

device-mapper: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

LVM2: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

dhcpcd: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

distcc: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

popt: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

inputattach: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

ppp: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

rp-pppoe: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

libaal: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

reiser4progs: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

squashfs: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

cpio: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

db: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

postfix: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

mutt: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

msmtp: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

slrn: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

raidtools: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

linux: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

cdrtools: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

blfs-bootscripts: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

syslinux: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

klibc: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

unionfs: prep-chroot
	make -C $(PKG)/$@ chroot
	make unmount

initramfs: prep-chroot
	make -C $@ chroot
	make unmount

strip: prep-chroot
	@chroot $(MP) $(chenvstrip) 'cd $(ROOT) && make ch-strip'
	make unmount

# Do Not call the rules below manually!
# They are used internally and must be called by
# other rules.

lfs-binutils-pass1-scpt:
	$(MAKE) -C $(PKG)/binutils pass1

lfs-gcc-pass1-scpt:
	$(MAKE) -C $(PKG)/gcc pass1

lfs-linux-libc-headers-scpt:
	$(MAKE) -C $(PKG)/linux-libc-headers stage1

lfs-glibc-scpt:
	$(MAKE) -C $(PKG)/glibc stage1

lfs-adjust-toolchain-scpt:
	$(MAKE) -C $(PKG)/binutils adjust-toolchain

lfs-tcl-scpt:
	$(MAKE) -C $(PKG)/tcl stage1

lfs-expect-scpt:
	$(MAKE) -C $(PKG)/expect stage1

lfs-dejagnu-scpt:
	$(MAKE) -C $(PKG)/dejagnu stage1

lfs-gcc-pass2-scpt:
	$(MAKE) -C $(PKG)/gcc pass2

lfs-binutils-pass2-scpt:
	$(MAKE) -C $(PKG)/binutils pass2

lfs-gawk-scpt:
	$(MAKE) -C $(PKG)/gawk stage1

lfs-coreutils-scpt:
	$(MAKE) -C $(PKG)/coreutils stage1

lfs-bzip2-scpt:
	$(MAKE) -C $(PKG)/bzip2 stage1

lfs-gzip-scpt:
	$(MAKE) -C $(PKG)/gzip stage1

lfs-diffutils-scpt:
	$(MAKE) -C $(PKG)/diffutils stage1

lfs-findutils-scpt:
	$(MAKE) -C $(PKG)/findutils stage1

lfs-make-scpt:
	$(MAKE) -C $(PKG)/make stage1

lfs-grep-scpt:
	$(MAKE) -C $(PKG)/grep stage1

lfs-sed-scpt:
	$(MAKE) -C $(PKG)/sed stage1

lfs-gettext-scpt:
	$(MAKE) -C $(PKG)/gettext stage1

lfs-ncurses-scpt:
	$(MAKE) -C $(PKG)/ncurses stage1

lfs-patch-scpt:
	$(MAKE) -C $(PKG)/patch stage1

lfs-tar-scpt:
	$(MAKE) -C $(PKG)/tar stage1

lfs-texinfo-scpt:
	$(MAKE) -C $(PKG)/texinfo stage1

lfs-bash-scpt:
	$(MAKE) -C $(PKG)/bash stage1

lfs-m4-scpt:
	$(MAKE) -C $(PKG)/m4 stage1

lfs-bison-scpt:
	$(MAKE) -C $(PKG)/bison stage1

lfs-flex-scpt:
	$(MAKE) -C $(PKG)/flex stage1

lfs-util-linux-scpt:
	$(MAKE) -C $(PKG)/util-linux stage1

lfs-perl-scpt:
	$(MAKE) -C $(PKG)/perl stage1

lfs-strip-scpt:
	@-strip --strip-debug $(WD)/lib/*
	@-strip --strip-unneeded $(WD)/{,s}bin/*
	@-rm -rf $(WD)/{doc,info,man}
	@touch lfs-strip-scpt

ch-linux-libc-headers: popdev
	make -C $(PKG)/linux-libc-headers stage2

ch-man-pages: popdev
	make -C $(PKG)/man-pages stage2

ch-glibc: popdev
	make -C $(PKG)/glibc stage2

ch-re-adjust-toolchain: popdev
	make -C $(PKG)/binutils re-adjust-toolchain

ch-binutils: popdev
	make -C $(PKG)/binutils stage2

ch-gcc: popdev
	make -C $(PKG)/gcc stage2

ch-coreutils: popdev
	make -C $(PKG)/coreutils stage2

ch-zlib: popdev
	make -C $(PKG)/zlib stage2

ch-mktemp: popdev
	make -C $(PKG)/mktemp stage2

ch-iana-etc: popdev
	make -C $(PKG)/iana-etc stage2

ch-findutils: popdev
	make -C $(PKG)/findutils stage2

ch-gawk: popdev
	make -C $(PKG)/gawk stage2

ch-sharutils: popdev
	make -C $(PKG)/sharutils stage2

ch-ncurses: popdev
	make -C $(PKG)/ncurses stage2

ch-readline: popdev
	make -C $(PKG)/readline stage2

ch-vim: popdev
	make -C $(PKG)/vim stage2

ch-m4: popdev
	make -C $(PKG)/m4 stage2

ch-bison: popdev
	make -C $(PKG)/bison stage2

ch-less: popdev
	make -C $(PKG)/less stage2

ch-groff: popdev
	make -C $(PKG)/groff stage2

ch-sed: popdev
	make -C $(PKG)/sed stage2

ch-flex: popdev
	make -C $(PKG)/flex stage2

ch-gettext: popdev
	make -C $(PKG)/gettext stage2

ch-inetutils: popdev
	make -C $(PKG)/inetutils stage2

ch-iproute2: popdev
	make -C $(PKG)/iproute2 stage2

ch-perl: popdev
	make -C $(PKG)/perl stage2

ch-texinfo: popdev
	make -C $(PKG)/texinfo stage2

ch-autoconf: popdev
	make -C $(PKG)/autoconf stage2

ch-automake: popdev
	make -C $(PKG)/automake stage2

ch-bash: popdev
	make -C $(PKG)/bash stage2

ch-file: popdev
	make -C $(PKG)/file stage2

ch-libtool: popdev
	make -C $(PKG)/libtool stage2

ch-bzip2: popdev
	make -C $(PKG)/bzip2 stage2

ch-diffutils: popdev
	make -C $(PKG)/diffutils stage2

ch-kbd: popdev
	make -C $(PKG)/kbd stage2

ch-e2fsprogs: popdev
	make -C $(PKG)/e2fsprogs stage2

ch-grep: popdev
	make -C $(PKG)/grep stage2

ch-grub: popdev
	make -C $(PKG)/grub stage2

ch-gzip: popdev
	make -C $(PKG)/gzip stage2

ch-hotplug: popdev
	make -C $(PKG)/hotplug stage2

ch-man: popdev
	make -C $(PKG)/man stage2

ch-make: popdev
	make -C $(PKG)/make stage2

ch-module-init-tools: popdev
	make -C $(PKG)/module-init-tools stage2

ch-patch: popdev
	make -C $(PKG)/patch stage2

ch-procps: popdev
	make -C $(PKG)/procps stage2

ch-psmisc: popdev
	make -C $(PKG)/psmisc stage2

ch-shadow: popdev
	make -C $(PKG)/shadow stage2

ch-sysklogd: popdev
	make -C $(PKG)/sysklogd stage2

ch-sysvinit: popdev
	make -C $(PKG)/sysvinit stage2

ch-tar: popdev
	make -C $(PKG)/tar stage2

ch-udev: popdev
	make -C $(PKG)/udev stage2

ch-util-linux: popdev
	make -C $(PKG)/util-linux stage2

ch-lfs-bootscripts: popdev
	make -C $(PKG)/lfs-bootscripts stage2

ch-environment:
	@cp -ra $(ROOT)/etc/sysconfig /etc
	@-cp $(ROOT)/etc/inputrc /etc
	@-cp $(ROOT)/etc/bashrc /etc
	@-cp $(ROOT)/etc/profile /etc
	@-dircolors -p > /etc/dircolors
	@-cp $(ROOT)/etc/hosts /etc
	@-cp $(ROOT)/etc/fstab /etc

ch-wget: popdev
	make -C $(PKG)/wget stage2

ch-reiserfsprogs: popdev
	make -C $(PKG)/reiserfsprogs stage2

ch-xfsprogs: popdev
	make -C $(PKG)/xfsprogs stage2

ch-slang: popdev
	make -C $(PKG)/slang stage2

ch-nano: popdev
	make -C $(PKG)/nano stage2

ch-joe: popdev
	make -C $(PKG)/joe stage2

ch-screen: popdev
	make -C $(PKG)/screen stage2

ch-openssl: popdev
	make -C $(PKG)/openssl stage2

ch-curl: popdev
	make -C $(PKG)/curl stage2

ch-gpm: popdev
	make -C $(PKG)/gpm stage2

ch-zip: popdev
	make -C $(PKG)/zip stage2

ch-unzip: popdev
	make -C $(PKG)/unzip stage2

ch-lynx: popdev
	make -C $(PKG)/lynx stage2

ch-libxml2: popdev
	make -C $(PKG)/libxml2 stage2

ch-expat: popdev
	make -C $(PKG)/expat stage2

ch-subversion: popdev
	make -C $(PKG)/subversion stage2

ch-docbook-xml: popdev
	make -C $(PKG)/docbook-xml stage2

ch-libxslt: popdev
	make -C $(PKG)/libxslt stage2

ch-docbook-xsl: popdev
	make -C $(PKG)/docbook-xsl stage2

ch-html_tidy: popdev
	make -C $(PKG)/html_tidy stage2

ch-LFS-BOOK: popdev
	make -C $(PKG)/LFS-BOOK stage2

ch-libpng: popdev
	make -C $(PKG)/libpng stage2

ch-freetype: popdev
	make -C $(PKG)/freetype stage2

ch-fontconfig: popdev
	make -C $(PKG)/fontconfig stage2

ch-Xorg: popdev
	make -C $(PKG)/Xorg stage2

ch-freefont: popdev
	make -C $(PKG)/freefont stage2

ch-fonts-dejavu: popdev
	make -C $(PKG)/fonts-dejavu stage2

ch-update-fontsdir: popdev
	cd /usr/X11R6/lib/X11/fonts/TTF ; /usr/X11R6/bin/mkfontscale ; /usr/X11R6/bin/mkfontdir ; /usr/bin/fc-cache -f

ch-libjpeg: popdev
	make -C $(PKG)/libjpeg stage2

ch-libtiff: popdev
	make -C $(PKG)/libtiff stage2

ch-links: popdev
	make -C $(PKG)/links stage2

ch-openssh: popdev
	make -C $(PKG)/openssh stage2

ch-pkgconfig: popdev
	make -C $(PKG)/pkgconfig stage2

ch-libungif: popdev
	make -C $(PKG)/libungif stage2

ch-imlib2: popdev
	make -C $(PKG)/imlib2 stage2

ch-libIDL: popdev
	make -C $(PKG)/libIDL stage2

ch-glib2: popdev
	make -C $(PKG)/glib2 stage2

ch-pango: popdev
	make -C $(PKG)/pango stage2

ch-atk: popdev
	make -C $(PKG)/atk stage2

ch-gtk2: popdev
	make -C $(PKG)/gtk+2 stage2

ch-cvs: popdev
	make -C $(PKG)/cvs stage2

ch-firefox: popdev
	make -C $(PKG)/firefox stage2

ch-thunderbird: popdev
	make -C $(PKG)/thunderbird stage2

ch-startup-notification: popdev
	make -C $(PKG)/startup-notification stage2

ch-gvim: popdev
	make -C $(PKG)/vim stage3

ch-xfce: popdev
	make -C $(PKG)/xfce stage2

ch-lua: popdev
	make -C $(PKG)/lua stage2

ch-ion: popdev
	make -C $(PKG)/ion stage2

ch-irssi: popdev
	make -C $(PKG)/irssi stage2

ch-xchat: popdev
	make -C $(PKG)/xchat stage2

ch-samba: popdev
	make -C $(PKG)/samba stage2

ch-tcpwrappers: popdev
	make -C $(PKG)/tcpwrappers stage2

ch-portmap: popdev
	make -C $(PKG)/portmap stage2

ch-nfs-utils: popdev
	make -C $(PKG)/nfs-utils stage2

ch-traceroute: popdev
	make -C $(PKG)/traceroute stage2

ch-dialog: popdev
	make -C $(PKG)/dialog stage2

ch-ncftp: popdev
	make -C $(PKG)/ncftp stage2

ch-pciutils: popdev
	make -C $(PKG)/pciutils stage2

ch-nALFS: popdev
	make -C $(PKG)/nALFS stage2

ch-device-mapper: popdev
	make -C $(PKG)/device-mapper stage2

ch-LVM2: popdev
	make -C $(PKG)/LVM2 stage2

ch-dhcpcd: popdev
	make -C $(PKG)/dhcpcd stage2

ch-distcc: popdev
	make -C $(PKG)/distcc stage2

ch-popt: popdev
	make -C $(PKG)/popt stage2

ch-inputattach: popdev
	make -C $(PKG)/inputattach stage2

ch-ppp: popdev
	make -C $(PKG)/ppp stage2

ch-rp-pppoe: popdev
	make -C $(PKG)/rp-pppoe stage2

ch-libaal: popdev
	make -C $(PKG)/libaal stage2

ch-reiser4progs: popdev
	make -C $(PKG)/reiser4progs stage2

ch-squashfs: popdev
	make -C $(PKG)/squashfs stage2

ch-cpio: popdev
	make -C $(PKG)/cpio stage2

ch-db: popdev
	make -C $(PKG)/db stage2

ch-postfix: popdev
	make -C $(PKG)/postfix stage2

ch-mutt: popdev
	make -C $(PKG)/mutt stage2

ch-msmtp: popdev
	make -C $(PKG)/msmtp stage2

ch-slrn: popdev
	make -C $(PKG)/slrn stage2

ch-raidtools: popdev
	make -C $(PKG)/raidtools stage2

ch-linux: popdev
	make -C $(PKG)/linux stage2

ch-cdrtools: popdev
	make -C $(PKG)/cdrtools stage2

ch-blfs-bootscripts: popdev
	make -C $(PKG)/blfs-bootscripts stage2

ch-syslinux: popdev
	make -C $(PKG)/syslinux stage2

ch-klibc: popdev
	make -C $(PKG)/klibc stage2

ch-initramfs: popdev
	make -C initramfs

ch-unionfs: popdev
	make -C $(PKG)/unionfs stage2

ch-strip: popdev
	@$(WD)/bin/find /{,usr/}{bin,lib,sbin} -type f -exec $(WD)/bin/strip --strip-debug '{}' ';'

##################################
# Rules to create the iso
#----------------------------------

prepiso: unmount
	@-rm $(MP)/etc/rc.d/rc{2,3,5}.d/{K,S}21xprint
	@-rm $(MP)/root/.bash_history
	@>$(MP)/var/log/btmp
	@>$(MP)/var/log/wtmp
	@>$(MP)/var/log/lastlog
	@install -m644 etc/issue $(MP)/etc/issue
	@install -m644 isolinux/{isolinux.cfg,*.msg,splash.lss} $(MP)/boot/isolinux
	@sed -i "s/Version:/Version: $(VERSION)/" $(MP)/etc/issue
	@sed -i "s/Version:/Version: $(VERSION)/" $(MP)/boot/isolinux/boot.msg
	@install -m600 root/.bashrc $(MP)/root/.bashrc
	@install -m644 etc/X11/app-defaults/XTerm $(MP)/etc/X11/app-defaults/XTerm
	@install -m644 etc/X11/twm/system.twmrc $(MP)/etc/X11/twm/system.twmrc
	@install -m755 scripts/{net-setup,greeting,livecd-login,ll,shutdown-helper} $(MP)/usr/bin/
	@cp -ra root $(MP)/etc/skel
	@-mv $(MP)/bin/uname.real $(MP)/bin/uname
	@-mkdir $(MP)/iso
	@cp -rav $(MP)/sources $(MP)/iso && \
	 cp -rav $(MP)/boot $(MP)/iso && \
	 rm -f iso/root.sqfs && \
	 $(WD)/bin/mksquashfs $(MP) $(MP)/iso/root.sqfs -info -e \
	 boot sources tools iso lfs-livecd lost+found tmp proc && \
	 echo "LFS-LIVECD" > $(MP)/iso/LFS
	@touch prepiso

iso: prepiso
	cd $(MP)/iso ; $(WD)/bin/mkisofs -R -l -L -D -o $(MKTREE)/lfslivecd-$(VERSION).iso -b boot/isolinux/isolinux.bin \
	-c boot/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -V "LFS_CD" ./

# Rules to clean your tree. 
# "clean" removes package directories and
# "scrub" also removes all sources and the uname modules - basically
# returning the tree to the condition it was in when it was unpacked

clean: unmount
	@-rm -rf $(WD) $(MP)$(WD)
	@-userdel lfs
	@-groupdel lfs
	@-rm -rf /home/lfs
	@-rm {prepiso,lfsuser,lfs-strip,lfs-strip-scpt,unamemod}
	@-rm $(PKG)/binutils/{,re-}adjust-toolchain
	@-for i in `ls $(PKG)` ; do $(MAKE) -C $(PKG)/$$i clean ; done
	@-var=`find packages -name ".pass2"` && for i in $$var ; do rm -rf $$i ; done

scrub: clean
	@-for i in bin boot dev etc home iso lib media mnt opt proc root sbin srv sys tmp \
	 usr var ; do rm -rf $(MP)/$$i ; done
	@-rm $(MP)/{etc,root}.tar.bz2
	@-rm lfslivecd-$(VERSION).iso

clean_sources:
	@-rm -rf $(SRC) $(MP)$(SRC)
	@-for i in `ls $(PKG)` ; do rm -rf $(PKG)/$$i/{*.gz,*.bz2,*.zip,*.tgz} ; done

unmount:
	@-umount $(MP)/dev/shm
	@-umount $(MP)/dev/pts
	@-umount $(MP)/dev
	@-umount $(MP)/proc
	@-umount $(MP)/sys

.PHONY: lfs-base pre-which pre-wget tools prep-chroot chroot createdirs createfiles popdev \
	clean scrub unloadmodule unmount lfs-wget lfs-rm-wget lfs-binutils-pass1 lfs-gcc-pass1 \
	lfs-linux-libc-headers lfs-glibc lfs-adjust-toolchain lfs-tcl lfs-expect lfs-dejagnu lfs-gcc-pass2 \
	lfs-binutils-pass2 lfs-gawk lfs-coreutils lfs-bzip2 lfs-gzip lfs-diffutils lfs-findutils lfs-make \
	lfs-grep lfs-gettext lfs-ncurses lfs-patch lfs-tar lfs-texinfo lfs-bash lfs-m4 lfs-bison lfs-flex \
	lfs-util-linux lfs-perl
