# Makefile for automating the LFS LiveCD build
# Written by Jeremy Huntwork, 2004-1-09

# Edit this line to match the mount-point of the
# partition you'll be using to build the cd.
export MP := /mnt/lfs

# Timezone, obviously ;)
export timezone := America/New_York

# Don't edit these!
export WD := /tools
export SRC := sources
export PKG := packages
export MKTREE := mklivecd
export DLP := $(MKTREE)/$(SRC)
export FTP := ftp://ftp.lfs-matrix.de/pub/lfs/lfs-packages/conglomeration
export CFLAGS := -Os -s
export lfsenv := exec env -i CFLAGS=' $(CFLAGS) ' LFS=$(MP) LC_ALL=POSIX PATH=$(WD)/bin:/bin:/usr/bin /bin/bash -c
export lfsbash := set +h && umask 022 && cd $(MP)/$(MKTREE)
export chenv1 := $(WD)/bin/env -i HOME=/root TERM="$$TERM" PS1='\u:\w\$$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin:$(WD)/bin $(WD)/bin/bash -c
export chbash1 := SHELL=$(WD)/bin/bash
export WHICH= $(WD)/bin/which
export WGET= wget -c --passive-ftp

FTPGET= $(WD)/bin/ftpget
WGET_V= 1.9.1

#RULES

.PHONY: all lfs-base lfsuser which wget unamemod tools prep-chroot chroot createdirs createfiles popdev \
	clean scrub unloadmodule unmount

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
	@-chown -R lfs $(WD) $(MP)$(WD) $(WD)/bin $(SRC) $(PKG)
	@echo ""
	@echo "=========================="
	@echo " Building LFS Base System"
	@echo "=========================="
	@echo ""
	@make unamemod
	@make lfs-which
	@make lfs-wget
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) tools'"
	@make prep-chroot
	@chroot "$(MP)" $(chenv1) 'chown -R 0:0 $(WD) && cd mklivecd && make chroot $(chbash1)'
	@make unloadmodule
	@make unmount

lfsuser: unamemod
	@-groupadd lfs
	@-useradd -s /bin/bash -g lfs -m -k /dev/null lfs

which: lfsuser
	@echo "#!/bin/sh" > $(WHICH)
	@echo 'type -pa "$$@" | head -n 1 ; exit $${PIPESTATUS[0]}' >> $(WHICH)
	@chmod 755 $(WHICH)

wget: lfsuser
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
	@if [ ! -f uname/uname_i486.ko ] ; then echo "" && echo "=====> Making Uname Module" && echo "" && \
	  make -C /usr/src/linux SUBDIRS=$(MP)/$(MKTREE)/uname modules ; fi
	@lsmod 1> $(WD)/.file
	@if ! grep -q uname_i486 $(WD)/.file ; then insmod uname/uname_i486.ko ; fi
	@-rm -f $(WD)/.file

tools:  lfs-binutils-pass1-scpt lfs-gcc-pass1-scpt lfs-linux-libc-headers-scpt lfs-glibc-scpt \
	lfs-adjust-toolchain-scpt lfs-tcl-scpt lfs-expect-scpt lfs-dejagnu-scpt lfs-gcc-pass2-scpt lfs-binutils-pass2-scpt \
	lfs-gawk-scpt lfs-coreutils-scpt lfs-bzip2-scpt lfs-gzip-scpt lfs-diffutils-scpt lfs-findutils-scpt lfs-make-scpt \
	lfs-grep-scpt lfs-sed-scpt lfs-gettext-scpt lfs-ncurses-scpt lfs-patch-scpt lfs-tar-scpt lfs-texinfo-scpt \
	lfs-bash-scpt lfs-m4-scpt lfs-bison-scpt lfs-flex-scpt lfs-util-linux-scpt lfs-perl-scpt lfs-strip-scpt
	@cp /etc/resolv.conf $(WD)/etc

prep-chroot:
	@-mkdir -p $(MP)/{proc,sys}
	@-mount -t proc proc $(MP)/proc && mount -t sysfs sysfs $(MP)/sys && \
	 mount -f -t ramfs ramfs $(MP)/dev && mount -f -t tmpfs tmpfs $(MP)/dev/shm && \
	 mount -f -t devpts -o gid=4,mode=620 devpts $(MP)/dev/pts

chroot: createdirs createfiles popdev ch-linux-libc-headers ch-man-pages ch-glibc ch-re-adjust-toolchain


# Rules for building tools/stage1
# These can be called individually, if necessary

lfs-which: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) which'"

lfs-wget: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) wget'"
	
lfs-binutils-pass1: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-binutils-pass1-scpt'"

lfs-gcc-pass1: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-gcc-pass1-scpt'"

lfs-linux-libc-headers: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-linux-libc-headers-scpt'"

lfs-glibc: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-glibc-scpt'"

lfs-adjust-toolchain: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-adjust-toolchain-scpt'"

lfs-tcl: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-tcl-scpt'"

lfs-expect: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-expect-scpt'"

lfs-dejagnu: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-dejagnu-scpt'"

lfs-gcc-pass2: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-gcc-pass2-scpt'"

lfs-binutils-pass2: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-binutils-pass2-scpt'"

lfs-gawk: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-gawk-scpt'"

lfs-coreutils: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-coreutils-scpt'"

lfs-bzip2: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-bzip2-scpt'"

lfs-gzip: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-gzip-scpt'"

lfs-diffutils: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-diffutils-scpt'"

lfs-findutils: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-findutils-scpt'"

lfs-make: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-make-scpt'"

lfs-grep: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-grep-scpt'"

lfs-sed: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-sed-scpt'"

lfs-gettext: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-gettext-scpt'"

lfs-ncurses: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-ncurses-scpt'"

lfs-patch: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-patch-scpt'"

lfs-tar: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-tar-scpt'"

lfs-texinfo: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-texinfo-scpt'"

lfs-bash: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-bash-scpt'"

lfs-m4: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-m4-scpt'"

lfs-bison: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-bison-scpt'"

lfs-flex: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-flex-scpt'"

lfs-util-linux: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-util-linux-scpt'"

lfs-perl: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-perl-scpt'"

lfs-strip: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-strip-scpt'"

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
	@mv $(WD)/etc/resolv.conf /etc

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

linux-libc-headers: unamemod
	$(MAKE) -C $(PKG)/$@ chroot

man-pages: unamemod
	$(MAKE) -C $(PKG)/$@ chroot

glibc: unamemod
	$(MAKE) -C $(PKG)/$@ chroot

re-adjust-toolchain: unamemod
	$(MAKE) -C $(PKG)/binutils chroot-re-adjust-toolchain

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

ch-linux-libc-headers:
	$(MAKE) -C $(PKG)/linux-libc-headers stage2

ch-man-pages:
	$(MAKE) -C $(PKG)/man-pages stage2

ch-glibc:
	$(MAKE) -C $(PKG)/glibc stage2

ch-re-adjust-toolchain:
	$(MAKE) -C $(PKG)/binutils re-adjust-toolchain


# Rules to clean your tree. 
# "clean" removes package directories and
# "scrub" also removes all sources and the uname modules - basically
# returning the tree to the condition it was in when it was unpacked

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
