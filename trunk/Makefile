# Makefile for automating the LFS LiveCD build
# Written by Jeremy Huntwork, 2004-1-09

# Edit this line to match the mount-point of the
# partition you'll be using to build the cd.
export MP := /mnt/lfs

# Don't edit these!
export WD := /tools
export SRC := sources
export PKG := packages
export MKTREE := $(MP)/mklivecd
export FTP := ftp://ftp.lfs-matrix.de/pub/lfs/lfs-packages/conglomeration
export CFLAGS := -Os -s
WHICH= $(WD)/bin/which
FTPGET= $(WD)/bin/ftpget

# Package versions
WGET_V= 1.9.1

#RULES
all: lfs-base

lfs-base:
	@echo "==============================================================="
	@echo " Before you begin building the LiveCD image, please ensure "
	@echo " that the following is true: "
	@echo " 1) Your running kernel is the same version as the target "
	@echo "    kernel for the cd."
	@echo " 2) Your compiled kernel sources are located in /usr/src/linux "
	@echo "    (This is so we can build a uname module) "
	@echo "==============================================================="
	#@sleep 8
	#@if [ ! `type -pa which | head -n 1` ] ; then make which ; fi
	#@if [ ! `$(WCH) wget` ] ; then make wget ; fi
	@-mkdir -p $(MP)$(WD)/bin; ln -s $(MP)$(WD) /
	@-mkdir $(SRC)
	@make lfsuser
	@su - lfs -c "exec env -i CFLAGS=' $(CFLAGS) ' LFS=$(MP) LC_ALL=POSIX PATH=/tools/bin:/bin:/usr/bin \
	 /bin/bash -c 'set +h && umask 022 && cd $(MKTREE) && make which && make wget && make tools'"
	@make prep-chroot
	@chroot "$(MP)" $(WD)/bin/env -i HOME=/root TERM="$$TERM" PS1='\u:\w\$$ ' \
	 PATH=/bin:/usr/bin:/sbin:/usr/sbin:$(WD)/bin $(WD)/bin/bash -c 'chown -R 0:0 $(WD) && cd mklivecd && \
	 make chroot SHELL=$(WD)/bin/bash'
	@make unloadmodule
	@make unmount

lfsuser: unamemod
	@-groupadd lfs
	@-useradd -s /bin/bash -g lfs -m -k /dev/null lfs
	@-chown -R lfs $(WD) $(MP)$(WD) $(WD)/bin $(SRC) $(PKG)

which:
	@echo "#!/bin/sh" > $(WHICH)
	@echo 'type -pa "$$@" | head -n 1 ; exit $${PIPESTATUS[0]}' >> $(WHICH)
	@chmod 755 $(WHICH)

wget:
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
	@echo ""
	@echo "=====> Making Uname Module"
	@echo ""
	@make -C /usr/src/linux SUBDIRS=$(MKTREE)/uname modules
	@-insmod uname/uname_i486.ko

tools: lfs-binutils-pass1 lfs-gcc-pass1 lfs-linux-libc-headers lfs-glibc lfs-adjust-toolchain \
	lfs-tcl lfs-expect lfs-dejagnu lfs-gcc-pass2 lfs-binutils-pass2 lfs-gawk lfs-coreutils \
	lfs-bzip2 lfs-gzip lfs-diffutils lfs-findutils lfs-make lfs-grep lfs-sed lfs-gettext \
	lfs-ncurses lfs-patch lfs-tar lfs-texinfo lfs-bash lfs-m4 lfs-bison lfs-flex lfs-util-linux \
	lfs-perl lfs-strip

prep-chroot:
	@-mkdir -p $(MP)/{proc,sys}
	@-mount -t proc proc $(MP)/proc && mount -t sysfs sysfs $(MP)/sys && \
	 mount -f -t ramfs ramfs $(MP)/dev && mount -f -t tmpfs tmpfs $(MP)/dev/shm && \
	 mount -f -t devpts -o gid=4,mode=620 devpts $(MP)/dev/pts

chroot: createdirs createfiles popdev ch-linux-libc-headers


# Rules which can be called by themselves, if necessary
binutils-pass1: lfsuser
	$(MAKE) -C $(PKG)/binutils pre1

gcc-pass1: lfsuser
	$(MAKE) -C $(PKG)/gcc pre1

linux-libc-headers: lfsuser 
	$(MAKE) -C $(PKG)/$@ pre1

glibc: lfsuser
	$(MAKE) -C $(PKG)/$@ pre1

adjust-toolchain: lfsuser
	$(MAKE) -C $(PKG)/binutils pre-adjust

tcl: lfsuser
	$(MAKE) -C $(PKG)/tcl pre1

expect: lfsuser
	$(MAKE) -C $(PKG)/expect pre1

dejagnu: lfsuser
	$(MAKE) -C $(PKG)/dejagnu pre1

gcc-pass2: lfsuser
	$(MAKE) -C $(PKG)/gcc pre2

binutils-pass2: lfsuser
	$(MAKE) -C $(PKG)/binutils pre2

gawk: lfsuser
	$(MAKE) -C $(PKG)/gawk pre1

coreutils: lfsuser
	$(MAKE) -C $(PKG)/coreutils pre1

bzip2: lfsuser
	$(MAKE) -C $(PKG)/bzip2 pre1

gzip: lfsuser
	$(MAKE) -C $(PKG)/gzip pre1

diffutils: lfsuser
	$(MAKE) -C $(PKG)/diffutils pre1

findutils: lfsuser
	$(MAKE) -C $(PKG)/findutils pre1

make: lfsuser
	$(MAKE) -C $(PKG)/make pre1

grep: lfsuser
	$(MAKE) -C $(PKG)/grep pre1

sed: lfsuser
	$(MAKE) -C $(PKG)/sed pre1

gettext: lfsuser
	$(MAKE) -C $(PKG)/gettext pre1

ncurses: lfsuser
	$(MAKE) -C $(PKG)/ncurses pre1

patch: lfsuser
	$(MAKE) -C $(PKG)/patch pre1

tar: lfsuser
	$(MAKE) -C $(PKG)/tar pre1

texinfo: lfsuser
	$(MAKE) -C $(PKG)/texinfo pre1

bash: lfsuser
	$(MAKE) -C $(PKG)/bash pre1

m4: lfsuser
	$(MAKE) -C $(PKG)/m4 pre1

bison: lfsuser
	$(MAKE) -C $(PKG)/bison pre1

flex: lfsuser
	$(MAKE) -C $(PKG)/flex pre1

util-linux: lfsuser
	$(MAKE) -C $(PKG)/util-linux pre1

perl: lfsuser
	$(MAKE) -C $(PKG)/perl pre1

strip: lfsuser
	@-strip --strip-debug $(WD)/lib/*
	@-strip --strip-unneeded $(WD)/{,s}bin/*
	@-rm -rf $(WD)/{doc,info,man}

linux-libc-headers-chroot:
	$(MAKE) -C $(PKG)/linux-libc-headers prechroot

# DO NOT CALL THESE RULES - FOR SCRIPTING ONLY
# The rules below are what is used when the environment
# is properly set up during the make script and would
# not work properly if called directly from the command line.
lfs-binutils-pass1:
	@echo ""
	@echo "=========================="
	@echo " Building LFS Base System"
	@echo "=========================="
	@echo ""
	$(MAKE) -C $(PKG)/binutils pass1

lfs-gcc-pass1:
	$(MAKE) -C $(PKG)/gcc pass1

lfs-linux-libc-headers:
	$(MAKE) -C $(PKG)/linux-libc-headers stage1

lfs-glibc:
	$(MAKE) -C $(PKG)/glibc stage1

lfs-adjust-toolchain:
	$(MAKE) -C $(PKG)/binutils adjust-toolchain

lfs-tcl:
	$(MAKE) -C $(PKG)/tcl stage1

lfs-expect:
	$(MAKE) -C $(PKG)/expect stage1

lfs-dejagnu:
	$(MAKE) -C $(PKG)/dejagnu stage1

lfs-gcc-pass2:
	$(MAKE) -C $(PKG)/gcc pass2

lfs-binutils-pass2:
	$(MAKE) -C $(PKG)/binutils pass2

lfs-gawk:
	$(MAKE) -C $(PKG)/gawk stage1

lfs-coreutils:
	$(MAKE) -C $(PKG)/coreutils stage1

lfs-bzip2:
	$(MAKE) -C $(PKG)/bzip2 stage1

lfs-gzip:
	$(MAKE) -C $(PKG)/gzip stage1

lfs-diffutils:
	$(MAKE) -C $(PKG)/diffutils stage1

lfs-findutils:
	$(MAKE) -C $(PKG)/findutils stage1

lfs-make:
	$(MAKE) -C $(PKG)/make stage1

lfs-grep:
	$(MAKE) -C $(PKG)/grep stage1

lfs-sed:
	$(MAKE) -C $(PKG)/sed stage1

lfs-gettext:
	$(MAKE) -C $(PKG)/gettext stage1

lfs-ncurses:
	$(MAKE) -C $(PKG)/ncurses stage1

lfs-patch:
	$(MAKE) -C $(PKG)/patch stage1

lfs-tar:
	$(MAKE) -C $(PKG)/tar stage1

lfs-texinfo:
	$(MAKE) -C $(PKG)/texinfo stage1

lfs-bash:
	$(MAKE) -C $(PKG)/bash stage1

lfs-m4:
	$(MAKE) -C $(PKG)/m4 stage1

lfs-bison:
	$(MAKE) -C $(PKG)/bison stage1

lfs-flex:
	$(MAKE) -C $(PKG)/flex stage1

lfs-util-linux:
	$(MAKE) -C $(PKG)/util-linux stage1

lfs-perl:
	$(MAKE) -C $(PKG)/perl stage1

lfs-strip:
	@-strip --strip-debug $(WD)/lib/*
	@-strip --strip-unneeded $(WD)/{,s}bin/*
	@-rm -rf $(WD)/{doc,info,man}

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
	@-$(WD)/bin/ln -s $(WD)/lib/libgcc_s.so.1 /usr/lib
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

popdev:
	@-mknod -m 600 /dev/console c 5 1
	@-mknod -m 666 /dev/console c 1 3
	@-mount -n -t ramfs none /dev
	@-mknod -m 662 /dev/console c 5 1
	@-mknod -m 666 /dev/null c 1 3
	@-mknod -m 666 /dev/zero c 1 5
	@-mknod -m 666 /dev/ptmx c 5 2
	@-mknod -m 666 /dev/tty c 5 0 
	@-mknod -m 444 /dev/random c 1 8
	@-mknod -m 444 /dev/urandom c 1 9
	@chown root:tty /dev/{console,ptmx,tty}
	@-ln -s /proc/self/fd /dev/fd
	@-ln -s /proc/self/fd/0 /dev/stdin
	@-ln -s /proc/self/fd/1 /dev/stdout
	@-ln -s /proc/self/fd/2 /dev/stderr
	@-ln -s /proc/kcore /dev/core
	@-mkdir /dev/pts
	@-mkdir /dev/shm
	@-mount -t devpts -o gid=4,mode=620 none /dev/pts
	@-mount -t tmpfs none /dev/shm

ch-linux-libc-headers:
	$(MAKE) -C $(PKG)/linux-libc-headers stage2

# Rules to clean your tree. 
# "clean" removes package directories and
# "scrub" also removes all sources and the uname modules - basically
# returning the tree to the condition it was when it was unpacked

clean: unloadmodule unmount
	@-rm -rf $(WD)
	@-rm -rf $(MP)$(WD)
	@-userdel lfs
	@-rm -rf /home/lfs
	@-for i in `ls $(PKG)` ; do $(MAKE) -C $(PKG)/$$i clean ; done

scrub: clean
	@-rm -rf sources
	@-rm -rf uname/*.ko uname/*mod.c uname/*.o uname/.uname* uname/.tmp*
	@-var=`find packages -name ".pass2"` && for i in $$var ; do rm -rf $$i ; done
	@-for i in bin boot dev etc home lib media mnt opt proc root sbin srv sys tmp \
	 usr var ; do rm -rf $(MP)/$$i ; done

unloadmodule:
	@-rmmod uname_i486

unmount:
	@-umount $(MP)/dev/shm
	@-umount $(MP)/dev/pts
	@-umount $(MP)/dev
	@-umount $(MP)/proc
	@-umount $(MP)/sys
