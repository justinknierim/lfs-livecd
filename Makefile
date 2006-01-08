#
# Makefiles for automating the LFS LiveCD build
#
# Written by Jeremy Huntwork | jhuntwork AT linuxfromscratch DOT org
# Several additions and edits by Alexander Patrakov, Justin Knierim and
# Thomas Pegg
#
# These scripts are published under the GNU General Public License, version 2
#
#==============================================================================
#
# Unless otherwise noted, please try to keep all line lengths below 80 chars. 
#

# Place your personal customizations in Makefile.personal
# instead of editing this Makefile.
# Makefile.personal is deliberately not in SVN.

-include Makefile.personal

# LFS-ARCH: architecture for which the CD should be built.
# MP:       mount point
# timezone: default timezone
# pagesize: paper size for groff.
#           In utf8-newmake branch, create /etc/papersize instead
# ROOT:     name of this directory, as seen from chroot
# PM:       Parallel Build Level
# HTTP:     Default http server for the lfs-base packages
# HTTPBLFS: Default http server for the BLFS packages

export LFS-ARCH ?= x86
export MP ?= /mnt/lfs
export timezone ?= GMT
export pagesize ?= letter
export ROOT ?= /lfs-livecd
export PM ?= -j3
export HTTP ?= http://ftp.lfs-matrix.net/pub/lfs/conglomeration
export HTTPBLFS ?= http://ftp.lfs-matrix.net/pub/blfs/conglomeration

# Directory variables
#==============================================================================
export HOSTNAME := lfslivecd
export WD := /tools
export SRC := /sources
export LFSSRC := /lfs-sources
export PKG := packages
export MKTREE := $(MP)$(ROOT)

export CROSSVARS := vars/vars.$(LFS-ARCH)

include $(CROSSVARS)

export KVERS ?= 2.6.12.5

# Environment Variables
# The following lines need to be all on one line - no newlines.
#===============================================================================
ifndef CROSS
export lfsenv := exec env -i HOME=$$HOME CFLAGS='$(CFLAGS)' CXXFLAGS='$(CXXFLAGS)' LFS=$(MP) LC_ALL=POSIX PATH=$(WD)/bin:/bin:/usr/bin /bin/bash -c

export chenv-pre-bash := $(WD)/bin/env -i HOME=/root CFLAGS='$(CFLAGS)' CXXFLAGS='$(CXXFLAGS)' TERM=$(TERM) PS1='\u:\w\$$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin:$(WD)/bin $(WD)/bin/bash -c

export chenv-post-bash := $(WD)/bin/env -i HOME=/root CFLAGS='$(CFLAGS)' CXXFLAGS='$(CXXFLAGS)' TERM=$(TERM) PS1='\u:\w\$$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin:$(WD)/bin /bin/bash -c

else
export crossenv := exec env -i HOME=$$HOME CFLAGS='' CXXFLAGS='' LFS=$(MP) LC_ALL=POSIX BUILD32='$(32FLAGS)' BUILD64='$(64FLAGS)' PATH=$(CROSS_WD)/bin:/bin:/usr/bin /bin/bash -c

export lfsenv := exec env -i HOME=$$HOME CFLAGS='$(CFLAGS)' CXXFLAGS='$(CXXFLAGS)' LFS=$(MP) LC_ALL=POSIX CC='$(LFS_TARGET)-gcc' CXX='$(LFS_TARGET)-g++' AR='$(LFS_TARGET)-ar' AS='$(LFS_TARGET)-as' RANLIB='$(LFS_TARGET)-ranlib' LD='$(LFS_TARGET)-ld' STRIP='$(LFS_TARGET)-strip' BUILD32='$(32FLAGS)' BUILD64='$(64FLAGS)' PATH=$(CROSS_WD)/bin:/bin:/usr/bin /bin/bash -c

export chenv-pre-bash := $(WD)/bin/env -i HOME=/root CFLAGS='$(CFLAGS)' CXXFLAGS='$(CXXFLAGS)' TERM=$(TERM) PS1='\u:\w\$$ ' BUILD32='$(32FLAGS)' BUILD64='$(64FLAGS)' PATH=/bin:/usr/bin:/sbin:/usr/sbin:$(WD)/bin $(WD)/bin/bash -c

export chenv-post-bash := $(WD)/bin/env -i HOME=/root CFLAGS='$(CFLAGS)' CXXFLAGS='$(CXXFLAGS)' TERM=$(TERM) PS1='\u:\w\$$ ' BUILD32='$(32FLAGS)' BUILD64='$(64FLAGS)' PATH=/bin:/usr/bin:/sbin:/usr/sbin:$(WD)/bin /bin/bash -c
endif

export lfsbash := set +h && umask 022 && cd $(MKTREE)

export chenv-blfs := /usr/bin/env -i HOME=/root CFLAGS='$(CFLAGS)' TERM=$(TERM) PS1='\u:\w\$$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin INPUTRC=/etc/inputrc XML_CATALOG_FILES="/usr/share/xml/docbook/xsl-stylesheets-1.69.1/catalog.xml /etc/xml/catalog" /bin/bash -c

# More Environment Variables
#==============================================================================
export CXXFLAGS := $(CFLAGS)

export chbash-pre-bash := SHELL=$(WD)/bin/bash
export chbash-post-bash := SHELL=/bin/bash
export WHICH= $(WD)/bin/which
export WGET= wget

export BRW= "[0;1m"
export RED= "[0;31m"
export GREEN= "[0;32m"
export ORANGE= "[0;33m"
export BLUE= "[0;44m"
export WHITE= "[00m"


# TARGETS
#==============================================================================
#
# The build starts and ends here, first building the dependency targets,
# lfs-base, extend-lfs and iso, then it echoes a notice that it's finished. :)

all: test-host lfs-base extend-lfs iso
	@echo "The LiveCD, $(MKTREE)/lfslivecd-$(VERSION).iso, is ready!"

test-host:
	@if [ `whoami` != "root" ] ; then \
	 echo "You must be logged in as root." && exit 1 ; fi

# This target builds just a base LFS system, minus the kernel and bootscripts
#==============================================================================
lfs-base: lfsuser ln-root
	@if [ ! -d $(MP)$(WD)/bin ] ; then mkdir -p $(MP)$(WD)/bin ; fi
	@if [ ! -d $(MP)$(SRC) ] ; then mkdir $(MP)$(SRC) ; fi
	@if [ ! -d $(MP)$(LFSSRC) ] ; then mkdir $(MP)$(LFSSRC) ; fi
	@-ln -nsf $(MP)$(WD) /
	@-ln -nsf $(MP)$(SRC) /
	@-ln -nsf $(MP)$(LFSSRC) /
ifndef CROSS
	@-make unamemod
	@-chown -R lfs $(WD) $(MP)$(WD) $(WD)/bin \
	 $(LFSSRC) $(MP)$(LFSSRC) $(SRC) $(MP)$(SRC) $(MKTREE)
	@cp $(ROOT)/scripts/unpack $(WD)/bin
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) tools'"
	@touch $(PKG)/wget/.pass2
	@make prep-chroot
	@-mkdir $(MP)/etc
	@install -m644 -oroot -groot $(ROOT)/etc/{group,passwd} $(MP)/etc
	@-mkdir $(MP)/bin
	@if [ ! -f $(MP)/bin/bash ] ; then if [ ! -d $(MP) ] ; then \
	 mkdir $(MP)/bin ; fi ; ln -s ${WD}/bin/bash ${MP}/bin/bash ; fi
	@chroot "$(MP)" $(chenv-pre-bash) 'set +h && \
	 chown -R 0:0 $(WD) $(SRC) $(ROOT) && \
	 cd $(ROOT) && make pre-bash $(chbash-pre-bash)'
	@chroot "$(MP)" $(chenv-post-bash) 'set +h && cd $(ROOT) && \
	 make post-bash $(chbash-post-bash)'
	@-ln -s $(WD)/bin/wget $(MP)/usr/bin/wget
else
	@if [ ! -d $(MP)$(CROSS_WD)/bin ] ; then mkdir -p $(MP)$(CROSS_WD)/bin ; fi
	@-ln -nsf $(MP)$(CROSS_WD) /
	@-chown -R lfs $(WD) $(MP)$(WD) $(WD)/bin $(CROSS_WD) $(MP)$(CROSS_WD) $(CROSS_WD)/bin \
	 $(LFSSRC) $(MP)$(LFSSRC) $(SRC) $(MP)$(SRC) $(MKTREE)
	@cp $(ROOT)/scripts/unpack $(WD)/bin
	@cp $(ROOT)/scripts/unpack $(CROSS_WD)/bin
	@su - lfs -c "$(crossenv) '$(lfsbash) && $(MAKE) cross-tools'"
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) tools'"
	@make prep-chroot
	@-mkdir $(MP)/etc
	@install -m644 -oroot -groot $(ROOT)/etc/{group,passwd} $(MP)/etc
	@-mkdir $(MP)/bin
	@if [ ! -f $(MP)/bin/bash ] ; then if [ ! -d $(MP) ] ; then \
	 mkdir $(MP)/bin ; fi ; ln -s ${WD}/bin/bash ${MP}/bin/bash ; fi
	@chroot "$(MP)" $(chenv-pre-bash) 'set +h && \
	 chown -R 0:0 $(WD) $(SRC) $(ROOT) && \
	 cd $(ROOT) && make cross-pre-bash $(chbash-pre-bash)'
	@chroot "$(MP)" $(chenv-post-bash) 'set +h && cd $(ROOT) && \
	 make cross-post-bash $(chbash-post-bash)'
	@-ln -s $(WD)/bin/wget $(MP)/usr/bin/wget
endif

ln-root:
	@-ln -nsf $(MP)$(ROOT) /

extend-lfs: prep-chroot
	@cp $(WD)/bin/which $(MP)/usr/bin
	@cp $(ROOT)/scripts/unpack $(MP)/bin
ifndef CROSS
	@chroot "$(MP)" $(chenv-blfs) 'set +h && cd $(ROOT) && \
	 make blfs $(chbash-post-bash)'
else
ifeq ($(LFS-ARCH),sparc64)
	@chroot "$(MP)" $(chenv-blfs) 'set +h && cd $(ROOT) && \
	 make sparc64-blfs $(chbash-post-bash)'
endif
ifeq ($(LFS-ARCH),x86_64)
	@chroot "$(MP)" $(chenv-blfs) 'set +h && cd $(ROOT) && \
	 make x86_64-blfs $(chbash-post-bash)'
endif
endif
	@make unmount
	@touch $@

lfsuser:
	@-groupadd lfs
	@-useradd -s /bin/bash -g lfs -m -k /dev/null lfs
	@touch $@

pre-which:
	@echo "#!/bin/sh" > $(WHICH)
	@echo 'type -pa "$$@" | head -n 1 ; exit $${PIPESTATUS[0]}' >> $(WHICH)
	@chmod 755 $(WHICH)

pre-wget:
	@make -C $(PKG)/wget prebuild
ifdef CROSS
	@-ln -s $(WD)/bin/wget $(CROSS_WD)/bin
endif
	@touch $@
	
unamemod:
	@if [ ! -d ${WD}/bin ] ; then mkdir ${WD}/bin ; fi
	@install -m 755 uname/uname ${WD}/bin/
	@touch $@

cross-tools: pre-which pre-wget lfs-linux-libc-headers-scpt lfs-binutils-cross \
	lfs-gcc-cross-static lfs-glibc-scpt-32 lfs-glibc-scpt lfs-gcc-cross

ifndef CROSS
tools:  pre-which pre-wget lfs-binutils-pass1 lfs-gcc-pass1 \
	lfs-linux-libc-headers-scpt lfs-glibc-scpt lfs-adjust-toolchain \
	lfs-tcl-scpt lfs-expect-scpt lfs-dejagnu-scpt lfs-gcc-pass2 \
	lfs-binutils-pass2 lfs-gawk-scpt lfs-coreutils-scpt \
	lfs-bzip2-scpt lfs-gzip-scpt lfs-diffutils-scpt lfs-findutils-scpt \
	lfs-make-scpt lfs-grep-scpt lfs-sed-scpt lfs-gettext-scpt \
	lfs-ncurses-scpt lfs-patch-scpt lfs-tar-scpt lfs-texinfo-scpt \
	lfs-bash-scpt lfs-m4-scpt lfs-util-linux-scpt lfs-perl-scpt \
	lfs-wget-scpt lfs-strip
	@cp /etc/resolv.conf $(WD)/etc
else
tools: lfs-binutils-scpt lfs-gcc-scpt lfs-zlib-scpt lfs-gawk-scpt lfs-coreutils-scpt \
	lfs-bzip2-scpt lfs-gzip-scpt lfs-diffutils-scpt lfs-findutils-scpt lfs-make-scpt \
	lfs-grep-scpt lfs-sed-scpt lfs-gettext-scpt lfs-ncurses-scpt lfs-patch-scpt \
	lfs-tar-scpt lfs-bash-scpt lfs-util-linux-scpt lfs-wget-scpt
	@cp /etc/resolv.conf $(WD)/etc
endif


prep-chroot:
	@-mkdir -p $(MP)/{proc,sys}
	@-mount -t proc proc $(MP)/proc
	@-mount -t sysfs sysfs $(MP)/sys
	@-mount -f -t tmpfs none $(MP)/dev
	@-mount -f -t tmpfs tmpfs $(MP)/dev/shm
	@-mount -f -t devpts -o gid=4,mode=620 devpts $(MP)/dev/pts
	@touch $@

pre-bash: createdirs createfiles popdev ch-linux-libc-headers ch-man-pages \
	ch-glibc re-adjust-toolchain ch-binutils ch-gcc ch-coreutils \
	ch-zlib ch-mktemp ch-iana-etc ch-findutils ch-gawk \
	ch-m4 ch-bison ch-gpm ch-ncurses ch-readline ch-vim ch-less \
	ch-db ch-groff \
	ch-sed ch-flex ch-gettext ch-inetutils ch-iproute2 ch-perl ch-texinfo \
	ch-autoconf ch-automake ch-bash

post-bash: ch-file ch-libtool ch-bzip2 ch-diffutils ch-kbd ch-e2fsprogs \
	ch-grep ch-grub ch-gzip ch-hotplug ch-man-db ch-make \
	ch-module-init-tools ch-patch ch-procps ch-psmisc ch-shadow \
	ch-sysklogd ch-sysvinit ch-tar ch-udev ch-util-linux final-environment

cross-pre-bash: createdirs createfiles popdev lfs-tcl-scpt lfs-expect-scpt \
	lfs-dejagnu-scpt lfs-perl-scpt lfs-texinfo-scpt ch-linux-libc-headers \
	ch-man-pages ch-glibc-32 ch-glibc adjusting-toolchain ch-binutils ch-gcc \
	ch-coreutils ch-zlib ch-iana-etc ch-findutils ch-gawk ch-ncurses ch-readline \
	ch-vim ch-m4 ch-bison ch-less ch-db ch-groff ch-sed \
	ch-flex ch-gettext ch-inetutils \
	ch-perl ch-iproute2 ch-texinfo ch-autoconf ch-automake ch-bash

cross-post-bash: ch-file ch-libtool ch-bzip2 ch-diffutils ch-kbd ch-e2fsprogs \
	ch-grep ch-gzip ch-man-db ch-make ch-module-init-tools ch-patch ch-procps \
	ch-psmisc ch-shadow ch-sysklogd ch-sysvinit ch-tar ch-util-linux ch-udev \
	ch-hotplug final-environment
ifeq ($(LFS-ARCH),x86_64)
	make ch-grub
endif

blfs: ch-openssl ch-wget ch-reiserfsprogs ch-xfsprogs ch-nano ch-joe \
	ch-screen ch-pkgconfig ch-libidn ch-curl ch-zip ch-unzip ch-lynx ch-libxml2 ch-expat \
	ch-subversion ch-lfs-bootscripts ch-docbook-xml ch-libxslt \
	ch-docbook-xsl ch-html_tidy ch-LFS-BOOK ch-libpng ch-freetype \
	ch-fontconfig ch-Xorg-modular ch-freefont ch-inputattach ch-fonts-dejavu \
	ch-fonts-kochi ch-fonts-firefly ch-fonts-baekmuk ch-libjpeg ch-libtiff ch-libart_lgpl \
	ch-openssh ch-glib2 ch-libungif ch-imlib ch-imlib2 \
	ch-gc ch-w3m ch-cairo \
	ch-pango ch-atk ch-gtk2 ch-cvs ch-popt ch-samba ch-libIDL ch-firefox \
	ch-thunderbird ch-librsvg \
	ch-startup-notification chroot-gvim ch-xfce ch-vte ch-exo \
	ch-XML-Parser ch-Terminal ch-mousepad ch-irssi \
	ch-xchat ch-wireless_tools ch-tcpwrappers ch-portmap ch-nfs-utils \
	ch-traceroute ch-rsync ch-jhalfs ch-sudo \
	ch-dialog ch-ncftp ch-pciutils ch-nALFS ch-device-mapper ch-LVM2 ch-dmraid \
	ch-dhcpcd ch-distcc ch-ppp ch-rp-pppoe ch-libaal ch-reiser4progs \
	ch-squashfs ch-cpio ch-mutt ch-msmtp ch-tin ch-mdadm ch-which \
	ch-strace ch-iptables ch-eject ch-xlockmore ch-hdparm ch-linux \
	ch-ctags ch-unionfs ch-initramfs ch-cdrtools ch-blfs-bootscripts \
	ch-man-fr ch-man-pages-es ch-man-pages-it ch-manpages-de ch-manpages-ru \
	ch-anthy ch-scim ch-scim-tables ch-scim-anthy ch-scim-hangul \
	ch-libchewing ch-scim-chewing ch-scim-pinyin ch-scim-input-pad \
	ch-bin86 ch-lilo ch-syslinux ch-nALFS-profile update-fontsdir
ifeq ($(LFS-ARCH),ppc)
	make ch-yaboot
endif

x86_64-blfs: ch-openssl ch-wget ch-reiserfsprogs ch-nano ch-joe ch-screen ch-pkgconfig ch-libidn ch-curl \
	ch-zip ch-unzip ch-lynx ch-libxml2 ch-expat ch-subversion ch-lfs-bootscripts \
	ch-docbook-xml ch-libxslt ch-docbook-xsl ch-html_tidy ch-LFS-BOOK ch-squashfs ch-cpio \
	ch-man-fr ch-man-pages-es ch-man-pages-it ch-manpages-de ch-manpages-ru \
	ch-linux ch-ctags ch-unionfs ch-initramfs ch-cdrtools ch-syslinux

sparc64-blfs: ch-openssl ch-wget ch-reiserfsprogs ch-xfsprogs ch-nano \
	ch-joe ch-screen ch-pkgconfig ch-libidn ch-curl ch-zip ch-unzip ch-lynx ch-libxml2 ch-expat \
	ch-subversion ch-lfs-bootscripts ch-docbook-xml ch-libxslt \
	ch-docbook-xsl ch-html_tidy ch-LFS-BOOK ch-openssh \
	ch-glib2 ch-cvs ch-popt ch-samba ch-tcpwrappers \
	ch-portmap ch-nfs-utils ch-traceroute ch-dialog ch-ncftp ch-pciutils \
	ch-device-mapper ch-LVM2 ch-dhcpcd ch-distcc ch-ppp ch-rp-pppoe \
	ch-libaal ch-reiser4progs ch-squashfs ch-cpio ch-mutt ch-msmtp ch-tin \
	ch-mdadm ch-which ch-strace ch-iptables ch-eject ch-hdparm ch-linux \
	ch-ctags ch-unionfs ch-initramfs ch-cdrtools ch-blfs-bootscripts \
	ch-man-fr ch-man-pages-es ch-man-pages-it ch-manpages-de ch-manpages-ru \
	ch-elftoaout ch-silo

wget-list: ln-root
	@>wget-list ; \
	 for DIR in packages/* ; do \
	    make -C $${DIR} wget-list-entry || echo Never mind. ; \
	 done ; \
	 sed -i '/^$$/d' wget-list

# Targets for building packages individually. Useful for troubleshooting.
# These do not generally get used as part of the script. They're for manual
# use only ie, 'make [target]'
#==============================================================================

# The following takes the form 'make lfs-[package name]-only'	
lfs-%-only: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-$*-scpt'"

# The following two take the form 'make lfs-[package name]-only-pass#'	
lfs-%-only-pass1: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-$*-pass1'"

lfs-%-only-pass2: unamemod lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-$*-pass2'"

# The following takes the form 'make [package name]-only-ch'	
%-only-ch: prep-chroot
	make -C $(PKG)/$* chroot
	make unmount

gvim: prep-chroot
	make -C $(PKG)/vim chroot3
	make unmount

# The following takes the form 'make [package name]-clean'
# Cleans the build directory of a single package.

%-clean:
	make -C $(PKG)/$* clean

# The targets below can be called manually, but are also used by the
# scripts internally.
#==============================================================================

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
ifdef CROSS
	@-$(WD)/bin/install -d /{,usr/{,local},opt}/lib64
	@-$(WD)/bin/install -d /usr/lib/locale
	@-$(WD)/bin/ln -s ../lib/locale /usr/lib64
	@-$(WD)/bin/ln -s $(WD)/lib64/libgcc_s.so{,.1} /usr/lib64
endif

createfiles:
	@touch /var/run/utmp /var/log/{btmp,lastlog,wtmp}
	@chgrp utmp /var/run/utmp /var/log/lastlog
	@chmod 664 /var/run/utmp /var/log/lastlog
ifdef CROSS
	@chmod 600 /var/log/btmp
endif
	@mv $(WD)/etc/resolv.conf /etc

popdev:
	@if [ ! -c /dev/console ] ; then mknod -m 600 /dev/console c 5 1 && \
	 mknod -m 666 /dev/null c 1 3 ; fi
	@if ! tail -n 3 /proc/mounts | grep -q "dev tmpfs" ; then \
	 mount -n -t tmpfs tmpfs /dev && \
	 mknod -m 662 /dev/console c 5 1 ; \
	 mknod -m 666 /dev/null c 1 3 ; \
	 mknod -m 666 /dev/zero c 1 5 ; \
	 mknod -m 666 /dev/ptmx c 5 2 ; \
	 mknod -m 666 /dev/tty c 5 0 ; \
	 mknod -m 444 /dev/random c 1 8 ; \
	 mknod -m 444 /dev/urandom c 1 9 ; \
 	 chown root:tty /dev/{console,ptmx,tty} ; \
	 ln -s /proc/self/fd /dev/fd ; \
	 ln -s /proc/self/fd/0 /dev/stdin ; \
	 ln -s /proc/self/fd/1 /dev/stdout ; \
	 ln -s /proc/self/fd/2 /dev/stderr ; \
	 ln -s /proc/kcore /dev/core ; \
	 mkdir /dev/pts && mount -t devpts -o gid=4,mode=620 none /dev/pts ; \
	 mkdir /dev/shm && mount -t tmpfs none /dev/shm ; fi

# Do not call the targets below manually! They are used internally and must be
# called by other targets.
#==============================================================================

lfs-%-scpt:
	$(MAKE) -C $(PKG)/$* stage1

lfs-%-scpt-32:
	$(MAKE) -C $(PKG)/$* stage1-32

lfs-%-cross:
	$(MAKE) -C $(PKG)/$* cross

lfs-glibc-headers:
	$(MAKE) -C $(PKG)/glibc headers

lfs-gcc-cross-static:
	$(MAKE) -C $(PKG)/gcc cross-static

lfs-%-pass1:
	$(MAKE) -C $(PKG)/$* pass1

lfs-%-pass2:
	$(MAKE) -C $(PKG)/$* pass2

lfs-adjust-toolchain:
	$(MAKE) -C $(PKG)/binutils adjust-toolchain

lfs-strip:
	@-strip --strip-debug $(WD)/lib/*
	@-strip --strip-unneeded $(WD)/{,s}bin/*
	@-rm -rf $(WD)/{doc,info,man}
	@touch $@

ch-%: popdev
	make -C $(PKG)/$* stage2

ch-glibc-32: popdev
	make -C $(PKG)/glibc stage2-32

re-adjust-toolchain:
	make -C $(PKG)/binutils re-adjust-toolchain

adjusting-toolchain:
	gcc -dumpspecs | \
	perl -pi -e 's@/tools/lib/ld@/lib/ld@g;' \
     	 -e 's@/tools/lib64/ld@/lib64/ld@g;' \
     	 -e 's@\*startfile_prefix_spec:\n@$$_/usr/lib/ @g;' > \
     	 `dirname $$(gcc --print-libgcc-file-name)`/specs
	@touch $@ 

final-environment:
	@cp -ra $(ROOT)/etc/sysconfig /etc
	@-cp $(ROOT)/etc/inputrc /etc
	@-cp $(ROOT)/etc/bashrc /etc
	@-cp $(ROOT)/etc/profile /etc
	@-dircolors -p > /etc/dircolors
	@-cp $(ROOT)/etc/hosts /etc
	@-cp $(ROOT)/etc/fstab /etc

update-fontsdir:
	cd /usr/share/fonts ; mkfontscale ; mkfontdir ; fc-cache -f

chroot-gvim:
	make -C $(PKG)/vim stage3

# Targets to create the iso
#==============================================================================

prepiso: unmount
	@-rm $(MP)/root/.bash_history
	@>$(MP)/var/log/btmp
	@>$(MP)/var/log/wtmp
	@>$(MP)/var/log/lastlog
	@install -m644 etc/issue $(MP)/etc/issue
ifeq ($(LFS-ARCH),x86)
	@install -m644 isolinux/{isolinux.cfg,*.msg,splash.lss} $(MP)/boot/isolinux
	@sed -i "s/Version:/Version: $(VERSION)/" $(MP)/boot/isolinux/boot.msg
endif
ifeq ($(LFS-ARCH),x86_64)
	@install -m644 isolinux/{isolinux.cfg,*.msg,splash.lss} $(MP)/boot/isolinux
	@sed -i "s/Version:/Version: $(VERSION)/" $(MP)/boot/isolinux/boot.msg
endif
	@sed -i "s/Version:/Version: $(VERSION)/" $(MP)/etc/issue
	@install -m644 doc/README $(MP)/root/README
	@sed -i "s/\[version\]/$(VERSION)/" $(MP)/root/README
	@install -m600 root/.bashrc $(MP)/root/.bashrc
ifeq ($(LFS-ARCH),sparc64)
	@sed -i "s/Version:.*/Version: $(VERSION)/" $(MP)/boot/boot.msg
endif
	@install -m755 scripts/{net-setup,greeting,livecd-login,ll} $(MP)/usr/bin/
	@sed -e 's|_LINKER_|$(LINKER)|' -e 's|/lib/|/$(LIB_MAYBE64)/|' scripts/shutdown-helper > $(MP)/usr/bin/shutdown-helper
	@chmod 755 $(MP)/usr/bin/shutdown-helper
	@cp -ra root $(MP)/etc/skel
ifndef CROSS
	@-mv $(MP)/bin/uname.real $(MP)/bin/uname
endif
	@-mkdir $(MP)/iso
	@cp -rav $(MP)/lfs-sources $(MP)/iso
	@cp -rav $(MP)/boot $(MP)/iso
	@touch $@

$(MP)/iso/.root.sqfs:
	@$(WD)/bin/mksquashfs $(MP) .root.sqfs -info -e \
	 boot cross-tools sources lfs-sources tools iso lfs-livecd lost+found tmp proc >sqfs.log 2>&1 && \
	 mv .root.sqfs $@

iso: prepiso $(MP)/iso/.root.sqfs
ifeq ($(LFS-ARCH),x86)
	@cd $(MP)/iso ; $(MP)/usr/bin/mkisofs -R -l --allow-leading-dots -D -o \
	$(MKTREE)/lfslivecd-$(VERSION).iso -b boot/isolinux/isolinux.bin \
	-c boot/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table \
	-V "lfslivecd-$(VERSION)" ./
endif
ifeq ($(LFS-ARCH),x86_64)
	@cd $(MP)/iso ; $(MP)/usr/bin/mkisofs -R -l --allow-leading-dots -D -o \
	$(MKTREE)/lfslivecd-$(VERSION).iso -b boot/isolinux/isolinux.bin \
	-c boot/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table \
	-V "lfslivecd-$(VERSION)" ./
endif
ifeq ($(LFS-ARCH),ppc)
	@cd $(MP) ; ./usr/bin/mkisofs -hfs -part --allow-leading-dots \
	-map $(MKTREE)/$(PKG)/yaboot/map.hfs -no-desktop \
	-hfs-volid "lfslivecd-$(VERSION)" -V "lfslivecd-$(VERSION)" \
	-hfs-bless iso/boot -r -v -o $(MKTREE)/lfslivecd-$(VERSION).iso iso \
	 >$(MKTREE)/iso.log 2>&1
	@if ! grep -q "Blessing" $(MKTREE)/iso.log ; then \
	 echo "Iso incorrectly made! Boot directory not blessed." ; fi
endif
ifeq ($(LFS-ARCH),sparc64)
	@cd $(MP) ; ./usr/bin/mkisofs -v -R -l -D --allow-leading-dots \
	 -G iso/boot/isofs.b -B ... -r -V "lfslivecd-$(VERSION)" \
	 -o $(MKTREE)/lfslivecd-$(VERSION).iso iso >$(MKTREE)/iso.log 2>&1
endif

# Targets to clean your tree. 
#==============================================================================

clean: unmount
	@-rm -rf $(WD) $(MP)$(WD)
ifdef CROSS
	@-rm -rf $(CROSS_WD) $(MP)$(CROSS_WD)
endif
	@-userdel lfs
	@-groupdel lfs
	@-rm -rf /home/lfs
	@-rm {prepiso,lfsuser,unamemod,prep-chroot,lfs-base,extend-lfs,lfs-strip,}
	@-rm {sqfs.log,lfs-strip,pre-wget}
	@-rm $(PKG)/binutils/{,re-}adjust-toolchain
	@-rm $(PKG)/initramfs/stage2
	@-for i in `ls $(PKG)` ; do $(MAKE) -C $(PKG)/$$i clean ; done
	@find $(PKG) -name "pass*" -exec rm -rf \{} \;
	@find $(PKG) -name "stage*" -exec rm -rf \{} \;
	@find $(PKG) -name "*.log" -exec rm -rf \{} \;
	@find $(PKG)/*/ -type l -exec rm -fr \{} \;
ifdef CROSS
	@find $(PKG) -name "cross*" -exec rm -rf \{} \;
	@rm -f $(PKG)/glibc/headers
	@rm -f adjusting-toolchain
endif
	@echo find $(PKG)/binutils/* ! -path '$(PKG)/binutils/vars*' -xtype d -exec rm -rf \{} \;
	@rm -f $(PKG)/wget/{prebuild,.pass2}
	@rm -f $(PKG)/binutils/{a.out,dummy.c,.specstest}
	@rm -f initramfs/stage2
	@-rm -f $(SRC) $(ROOT) $(LFSSRC)

scrub: clean
	@-for i in bin boot dev etc home iso lib media mnt opt proc root sbin srv sys tmp \
	 usr var ; do rm -rf $(MP)/$$i ; done
	@-rm lfslivecd-$(VERSION).iso

clean_sources:
	@-rm $(SRC) ; rm -rf $(LFSSRC) $(MP)$(LFSSRC)
	@find packages/* -xtype l -exec rm -f \{} \;

unmount:
	@-umount $(MP)/dev/shm
	@-umount $(MP)/dev/pts
	@-umount $(MP)/dev
	@-umount $(MP)/proc
	@-umount $(MP)/sys
	@rm -f $(ROOT)/prep-chroot

.PHONY: unmount clean_sources scrub clean iso chroot-gvim update-fontsdir \
	final-environment re-adjust-toolchain ch-% ch-glibc-32 lfs-adjust-toolchain \
	lfs-%-scpt lfs-%-scpt-32 lfs-%-pass1 lfs-%-pass2 popdev createfiles createdirs \
	gvim %-only-ch lfs-%-only lfs-%-only-pass1 lfs-%-only-pass2 lfs-wget \
	lfs-rm-wget blfs post-bash pre-bash tools pre-which
