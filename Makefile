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

# Here are the various variables you might want/need to change.
# Variables mentioned in the README will not be commented on here.

export MPBASE ?= /mnt/lfs

# Free disk space needed for the build.
ROOTFS_MEGS := 1536

# Machine architecure, LiveCD version, and specific arch variables.
# When building a 32-bit CD from a 64-bit multilib host,
# please use "linux32 make" instead of plain "make".
#==============================================================================

export CD_ARCH := $(shell uname -m)
export CD_VERSION ?= $(CD_ARCH)-6.4

ifeq ($(CD_ARCH),i686)
export LINKER := ld-linux.so.2
endif

ifeq ($(CD_ARCH),x86_64)
export 64bit = true
export LINKER := ld-linux-x86-64.so.2
endif

# Default timezone
export timezone ?= GMT
# Default paper size for groff.
export pagesize ?= letter

# HTTP:     Default http server for the lfs-base packages
# HTTPBLFS: Default http server for the BLFS packages
export HTTP ?= http://kerrek.linuxfromscratch.org/pub/lfs/conglomeration
export HTTPBLFS ?= http://kerrek.linuxfromscratch.org/pub/blfs/conglomeration

#==============================================================================
# The following variables are not expected to be changed

export WD := /tools
export MP := $(MPBASE)/image
export ROOT := /lfs-livecd
export SRC := /sources
export LFSSRC := /lfs-sources
export PKG := packages

export MKTREE := $(MP)$(ROOT)

# Environment Variables
# The following lines need to be all on one line - no newlines.
#===============================================================================
export lfsenv := exec env -i HOME=$$HOME LFS=$(MP) LC_ALL=POSIX PATH=$(WD)/bin:/bin:/usr/bin /bin/bash -c

export chenv-pre-bash := $(WD)/bin/env -i HOME=/root TERM=$(TERM) PS1='\u:\w\$$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin:$(WD)/bin $(WD)/bin/bash -c

export chenv-post-bash := $(WD)/bin/env -i HOME=/root TERM=$(TERM) PS1='\u:\w\$$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin:$(WD)/bin /bin/bash -c

export lfsbash := set +h && umask 022 && cd $(MKTREE)

export chenv-blfs := /usr/bin/env -i HOME=/root TERM=$(TERM) PS1='\u:\w\$$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin INPUTRC=/etc/inputrc XML_CATALOG_FILES="/usr/share/xml/docbook/xsl-stylesheets-1.69.1/catalog.xml /etc/xml/catalog" /bin/bash -c

# More Environment Variables
#==============================================================================
export chbash-pre-bash := SHELL=$(WD)/bin/bash
export chbash-post-bash := SHELL=/bin/bash
export WHICH ?= $(WD)/bin/which
export WGET ?= wget

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
	@echo "The LiveCD, $(MPBASE)$(ROOT)/lfslivecd-$(CD_VERSION).iso, is ready!"

test-host:
	@if [ `whoami` != "root" ] ; then \
	 echo "You must be logged in as root." && exit 1 ; fi

test-env:
	env

# This image should be kept as clean as possible, i.e.:
# avoid creating files on it that you will later delete,
# preserve as many zeroed sectors as possible.
root.ext2:
	dd if=/dev/null of=root.ext2 bs=1M seek=$(ROOTFS_MEGS)
	mke2fs -F root.ext2
	tune2fs -c 0 -i 0 root.ext2

# This target populates the root.ext2 image and sets up some mounts
$(MKTREE): root.ext2
	mkdir -p $(MP) $(MPBASE)$(SRC) $(MPBASE)$(WD)/bin $(MPBASE)/iso/boot
	mount -o loop root.ext2 $(MP)
	mkdir -p $(MKTREE) $(MP)$(SRC) $(MP)$(WD)
	mkdir -p $(MP)/boot $(MP)$(LFSSRC) $(MPBASE)/iso$(LFSSRC)
	mkdir -p $(MP)/drivers $(MPBASE)/iso/drivers
	mount --bind $(MPBASE)$(ROOT) $(MP)$(ROOT)
	mount --bind $(MPBASE)$(WD) $(MP)$(WD)
	mount --bind $(MPBASE)$(SRC) $(MP)$(SRC)
	mount --bind $(MPBASE)/iso/boot $(MP)/boot
	mount --bind $(MPBASE)/iso$(LFSSRC) $(MP)$(LFSSRC)
	mount --bind $(MPBASE)/iso/drivers $(MP)/drivers
	-ln -nsf $(MPBASE)$(WD) /
	-ln -nsf $(MPBASE)$(SRC) /
	-ln -nsf $(MPBASE)$(ROOT) /
	-mkdir -p $(MP)/{proc,sys,dev/shm,dev/pts}
	-mount -t proc proc $(MP)/proc
	-mount -t sysfs sysfs $(MP)/sys
	-mount -t tmpfs shm $(MP)/dev/shm
	-mount -t devpts devpts $(MP)/dev/pts
	-mkdir -pv $(MP)/{bin,boot,etc/opt,home,lib,mnt,opt}
	-mkdir -pv $(MP)/{media/{floppy,cdrom},sbin,srv,var}
	-install -d -m 0750 $(MP)/root
	-install -d -m 1777 $(MP)/tmp $(MP)/var/tmp
	-mkdir -pv $(MP)/usr/{,local/}{bin,include,lib,sbin,src}
	-mkdir -pv $(MP)/usr/{,local/}share/{doc,info,locale,man}
	-mkdir -v  $(MP)/usr/{,local/}share/{misc,terminfo,zoneinfo}
	-mkdir -pv $(MP)/usr/{,local/}share/man/man{1..8}
	-for dir in $(MP)/usr $(MP)/usr/local; do ln -sv share/{man,doc,info} $$dir ; done
	-mkdir -v $(MP)/var/{lock,log,mail,run,spool}
	-mkdir -pv $(MP)/var/{opt,cache,lib/{misc,locate},local}
	-mknod -m 600 $(MP)/dev/console c 5 1
	-mknod -m 666 $(MP)/dev/null c 1 3
	-mknod -m 666 $(MP)/dev/zero c 1 5
	-mknod -m 666 $(MP)/dev/ptmx c 5 2
	-mknod -m 666 $(MP)/dev/tty c 5 0
	-mknod -m 444 $(MP)/dev/random c 1 8
	-mknod -m 444 $(MP)/dev/urandom c 1 9
	-ln -s /proc/self/fd $(MP)/dev/fd
	-ln -s /proc/self/fd/0 $(MP)/dev/stdin
	-ln -s /proc/self/fd/1 $(MP)/dev/stdout
	-ln -s /proc/self/fd/2 $(MP)/dev/stderr
	-ln -s /proc/kcore $(MP)/dev/core
	touch $(MKTREE)
ifdef 64bit
	-ln -nsf lib $(WD)/lib64
	-ln -nsf lib $(MP)/lib64
	-ln -nsf lib $(MP)/usr/lib64
endif

# This target builds just a base LFS system, minus the kernel and bootscripts
#==============================================================================
lfs-base: $(MKTREE) lfsuser
	@-chown -R lfs $(WD) $(MP)$(WD) $(WD)/bin \
	 $(MP)$(SRC) $(MKTREE)
	@cp $(ROOT)/scripts/unpack $(WD)/bin
	@make maybe-tools
	@touch $(PKG)/wget/.pass2
	@install -m644 -oroot -groot $(ROOT)/etc/{group,passwd} $(MP)/etc
	@-ln -s $(WD)/bin/bash $(MP)/bin/bash
	@chroot "$(MP)" $(chenv-pre-bash) 'set +h && \
	 chown -R 0:0 $(WD) $(SRC) $(ROOT) && \
	 cd $(ROOT) && make pre-bash $(chbash-pre-bash)'
	@chroot "$(MP)" $(chenv-post-bash) 'set +h && cd $(ROOT) && \
	 make post-bash $(chbash-post-bash)'
	@-ln -s $(WD)/bin/wget $(MP)/usr/bin/wget

extend-lfs: $(MKTREE)
	@cp $(WD)/bin/which $(MP)/usr/bin
	@cp $(ROOT)/scripts/unpack $(MP)/bin
	@chroot "$(MP)" $(chenv-blfs) 'set +h && cd $(ROOT) && \
	 make blfs $(chbash-post-bash)'
	@install -m644 etc/issue* $(MP)/etc

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
	@touch $@

maybe-tools:
	@if [ -f tools.tar.bz2 ] ; then \
	    echo "Found previously built tools. Unpacking..." && \
	    tar -C .. -jxpf tools.tar.bz2 ; \
	else \
	    su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) tools'" && \
	    echo "Packaging tools for later use..." && \
	    tar -C .. -jcpf tools.tar.bz2 tools ; \
	fi
	@touch $@

tools:  pre-which pre-wget lfs-binutils-pass1 lfs-gcc-pass1 \
	lfs-linux-headers-scpt lfs-glibc-scpt lfs-adjust-toolchain \
	lfs-tcl-scpt lfs-expect-scpt lfs-dejagnu-scpt lfs-gcc-pass2 \
	lfs-binutils-pass2 lfs-ncurses-scpt lfs-bash-scpt lfs-bzip2-scpt \
	lfs-coreutils-scpt lfs-diffutils-scpt lfs-e2fsprogs-scpt lfs-findutils-scpt \
	lfs-gawk-scpt lfs-gettext-scpt lfs-grep-scpt lfs-gzip-scpt lfs-m4-scpt \
	lfs-make-scpt lfs-patch-scpt lfs-perl-scpt lfs-sed-scpt \
	lfs-tar-scpt lfs-texinfo-scpt lfs-util-linux-ng-scpt lfs-wget-scpt \
	lfs-cdrtools-scpt lfs-zlib-scpt lfs-zisofs-tools-scpt
	@cp /etc/resolv.conf $(WD)/etc
	@touch $@

pre-bash: createfiles ch-linux-headers ch-man-pages \
	ch-glibc re-adjust-toolchain ch-binutils ch-gmp ch-mpfr ch-gcc ch-db \
	ch-sed ch-e2fsprogs ch-coreutils ch-iana-etc ch-m4 ch-bison \
	ch-ncurses ch-procps ch-libtool ch-zlib ch-perl ch-readline \
	ch-autoconf ch-automake ch-bash

post-bash: ch-bzip2 ch-diffutils ch-file ch-gawk ch-findutils \
	ch-flex ch-grub ch-gettext ch-grep ch-groff ch-gzip ch-inetutils \
	ch-iproute2 ch-kbd ch-less ch-make ch-man-db \
	ch-module-init-tools ch-patch ch-psmisc ch-shadow ch-sysklogd \
	ch-sysvinit ch-tar ch-texinfo ch-udev ch-util-linux-ng ch-vim \
	final-environment

blfs:   ch-openssl ch-wget ch-reiserfsprogs ch-xfsprogs ch-nano ch-joe \
	ch-screen ch-pkgconfig ch-libidn ch-libgpg-error ch-libgcrypt \
	ch-gnutls ch-curl ch-zip ch-unzip ch-lynx ch-libxml2 ch-expat \
	ch-subversion ch-lfs-bootscripts ch-livecd-bootscripts ch-docbook-xml \
	ch-libxslt ch-docbook-xsl ch-html_tidy ch-LFS-BOOK ch-libpng ch-freetype \
	ch-fontconfig ch-Xorg-base ch-Xorg-proto ch-Xorg-util ch-libXau ch-libXdmcp \
	ch-xcb-proto ch-libpthread-stubs ch-libxcb ch-ed ch-Xorg-lib \
	ch-xbitmaps ch-libdrm ch-Mesa ch-Xorg-app ch-xcursor-themes \
	ch-Xorg-font ch-XML-Parser ch-intltool ch-xkeyboard-config ch-luit \
	ch-dbus ch-pcre ch-glib2 ch-dbus-glib ch-pciutils ch-libusb ch-usbutils \
	ch-xorg-server ch-Xorg-driver \
	ch-freefont ch-fonts-dejavu ch-fonts-kochi ch-fonts-firefly ch-fonts-baekmuk \
	ch-libjpeg ch-libtiff ch-openssh ch-giflib \
	ch-gc ch-cairo ch-hicolor-icon-theme \
	ch-pango ch-atk ch-jasper ch-gtk2 ch-w3m ch-cvs ch-popt ch-samba ch-libIDL \
	ch-seamonkey ch-alsa-lib ch-alsa-utils ch-alsa-firmware \
	ch-libogg ch-libvorbis ch-speex ch-flac ch-libdvdcss ch-libtheora ch-xine-lib ch-parted \
	ch-librsvg ch-startup-notification chroot-gvim ch-vte ch-URI ch-xfce \
	ch-gxine ch-irssi ch-pidgin ch-net-tools \
	ch-xchat ch-wireless_tools ch-wpa_supplicant \
	ch-tcpwrappers ch-portmap ch-nfs-utils \
	ch-traceroute ch-rsync ch-jhalfs ch-sudo ch-bc ch-dialog ch-ncftp  \
	ch-device-mapper ch-LVM2 ch-dmraid ch-multipath-tools \
	ch-dhcpcd ch-distcc ch-ppp ch-rp-pppoe ch-pptp \
	ch-cpio ch-mutt ch-msmtp ch-tin ch-mdadm ch-which \
	ch-espeak ch-dotconf ch-speech-dispatcher ch-speechd-up ch-brltty  \
	ch-strace ch-iptables ch-eject ch-xlockmore ch-hdparm \
	ch-sysfsutils ch-pcmcia-cs ch-pcmciautils ch-ddccontrol ch-ddccontrol-db \
	ch-blfs-bootscripts ch-oui-data ch-Markdown ch-SmartyPants \
	ch-man-pages-fr ch-man-pages-es ch-man-pages-it ch-manpages-de ch-manpages-ru \
	ch-anthy ch-scim ch-scim-tables ch-scim-anthy ch-libhangul ch-scim-hangul \
	ch-libchewing ch-scim-chewing ch-scim-pinyin ch-scim-input-pad \
	ch-hibernate-script ch-slang ch-mc ch-fuse ch-dosfstools ch-ntfsprogs \
	ch-libaal ch-reiser4progs ch-vbetool ch-bin86 ch-lilo ch-syslinux \
	ch-scsi-firmware ch-net-firmware ch-linux32 ch-initramfs
ifeq ($(CD_ARCH),i686)
	make ch-linux
	make ch-binutils64
	make ch-gcc64
endif
	make ch-linux64
	make ch-gcc33
	make update-caches

wget-list:
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
lfs-%-only: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-$*-scpt'"

# The following two take the form 'make lfs-[package name]-only-pass#'	
lfs-%-only-pass1: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-$*-pass1'"

lfs-%-only-pass2: lfsuser
	@su - lfs -c "$(lfsenv) '$(lfsbash) && $(MAKE) lfs-$*-pass2'"

# The following takes the form 'make [package name]-only-ch'	
%-only-ch: $(MKTREE)
	make -C $(PKG)/$* chroot

gvim: $(MKTREE)
	make -C $(PKG)/vim chroot3

# The following takes the form 'make [package name]-clean'
# Cleans the build directory of a single package.

%-clean:
	make -C $(PKG)/$* clean

# The targets below can be called manually, but are also used by the
# scripts internally.
#==============================================================================

createfiles:
	@-$(WD)/bin/ln -s $(WD)/bin/{bash,cat,grep,pwd,stty} /bin
	@-$(WD)/bin/ln -s $(WD)/bin/perl /usr/bin
	@-$(WD)/bin/ln -s $(WD)/lib/libgcc_s.so{,.1} /usr/lib
	@-$(WD)/bin/ln -s $(WD)/lib/libstdc++.so{,.6} /usr/lib
	@-$(WD)/bin/ln -s bash /bin/sh
	@touch /var/run/utmp /var/log/{btmp,lastlog,wtmp}
	@chgrp utmp /var/run/utmp /var/log/lastlog
	@chmod 664 /var/run/utmp /var/log/lastlog
	@cp $(WD)/etc/resolv.conf /etc
	@-cp $(ROOT)/etc/hosts /etc
	@touch $@

# Do not call the targets below manually! They are used internally and must be
# called by other targets.
#==============================================================================

lfs-%-scpt:
	$(MAKE) -C $(PKG)/$* stage1

lfs-%-pass1:
	$(MAKE) -C $(PKG)/$* pass1

lfs-%-pass2:
	$(MAKE) -C $(PKG)/$* pass2

lfs-adjust-toolchain:
	$(MAKE) -C $(PKG)/binutils adjust-toolchain

ch-%:
	make -C $(PKG)/$* stage2

re-adjust-toolchain:
	make -C $(PKG)/binutils re-adjust-toolchain

final-environment:
	@cp -ra $(ROOT)/etc/sysconfig /etc
	@rm -rf /etc/sysconfig/.svn
	@-cp $(ROOT)/etc/inputrc /etc
	@-cp $(ROOT)/etc/bashrc /etc
	@-cp $(ROOT)/etc/profile /etc
	@-dircolors -p > /etc/dircolors
	@-cp $(ROOT)/etc/fstab /etc

update-caches:
	cd /usr/share/fonts ; mkfontscale ; mkfontdir ; fc-cache -f
	mandb -c 2>/dev/null
	echo 'dummy / ext2 defaults 0 0' >/etc/mtab
	updatedb --prunepaths='/sources /tools /lfs-livecd /lfs-sources /proc /sys /dev /tmp /var/tmp'
	echo >/etc/mtab

chroot-gvim:
	make -C $(PKG)/vim stage3

# Targets to create the iso
#==============================================================================

prepiso: $(MKTREE)
	@-rm $(MP)/root/.bash_history
	@-rm $(MP)/etc/resolv.conf
	@>$(MP)/var/log/btmp
	@>$(MP)/var/log/wtmp
	@>$(MP)/var/log/lastlog
	@sed -i 's/Version:$$/Version: $(CD_VERSION)/' $(MP)/boot/isolinux/boot.msg
	@sed -i 's/Version:$$/Version: $(CD_VERSION)/' $(MP)/etc/issue*
	@install -m644 doc/lfscd-remastering-howto.txt $(MP)/root
	@sed -e 's/\[Version\]/$(CD_VERSION)/' -e 's/\\_/_/g' \
	    doc/README.txt >$(MP)/root/README.txt
	@install -m600 root/.bashrc $(MP)/root/.bashrc
	@install -m755 scripts/{net-setup,greeting,livecd-login} $(MP)/usr/bin/ 
	@sed s/@LINKER@/$(LINKER)/ scripts/shutdown-helper.in >$(MP)/usr/bin/shutdown-helper
	@chmod 755 $(MP)/usr/bin/shutdown-helper
	@svn export --force root $(MP)/etc/skel

iso: prepiso
	@make unmount
	# Bug in old kernels requires a sync after unmounting the loop device
	# for data integrity.
	@sync ; sleep 1 ; sync
	# e2fsck optimizes directories and returns 1 after a clean build.
	# This is not a bug.
	@-e2fsck -f -p root.ext2
	@( LC_ALL=C ; export LC_ALL ; \
	    cat $(ROOT)/doc/README.html.head ; \
	    sed 's/\[version\]/$(CD_VERSION)/' $(ROOT)/doc/README.txt | \
		$(WD)/bin/Markdown --html4tags | $(WD)/bin/SmartyPants ; \
	    cat $(ROOT)/doc/README.html.tail ) >$(MPBASE)/iso/README.html
	@$(WD)/bin/mkzftree -F root.ext2 $(MPBASE)/iso/root.ext2
	@cd $(MPBASE)/iso ; $(WD)/bin/mkisofs -z -R -l --allow-leading-dots -D -o \
	$(MPBASE)$(ROOT)/lfslivecd-$(CD_VERSION).iso -b boot/isolinux/isolinux.bin \
	-c boot/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table \
	-V "lfslivecd-$(CD_VERSION)" ./
	@cd $(MPBASE)/iso ; $(WD)/bin/mkisofs -z -R -l --allow-leading-dots -D -o \
	$(MPBASE)$(ROOT)/lfslivecd-$(CD_VERSION)-nosrc.iso -b boot/isolinux/isolinux.bin \
	-c boot/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table \
	-m lfs-sources -V "lfslivecd-$(CD_VERSION)" ./

# Targets to clean your tree. 
#==============================================================================

clean: unmount
	@-rm -rf $(WD) $(MPBASE)$(WD) $(MPBASE)/iso
	@-userdel lfs
	@-groupdel lfs
	@-rm -rf /home/lfs
	@-rm {prepiso,lfsuser,lfs-base,extend-lfs,pre-wget,maybe-tools,createfiles}
	@-rm $(PKG)/binutils/{,re-}adjust-toolchain
	@-for i in `ls $(PKG)` ; do $(MAKE) -C $(PKG)/$$i clean ; done
	@find $(PKG) -name "pass*" -exec rm -rf \{} \;
	@find $(PKG) -name "stage*" -exec rm -rf \{} \;
	@find $(PKG) -name "*.log" -exec rm -rf \{} \;
	@rm -f $(PKG)/Xorg-*/*-stage2
	@rm -f $(PKG)/wget/prebuild
	@rm -f $(PKG)/binutils/{a.out,dummy.c,.spectest}
	@-rm -f $(SRC) $(ROOT)
	@find packages/* -xtype l -exec rm -f \{} \;
	@-rm root.ext2

scrub: clean
	@rm -f lfslivecd-$(CD_VERSION).iso lfslivecd-$(CD_VERSION)-nosrc.iso

mount: $(MKTREE)

unmount:
	-umount $(MP)/dev/shm
	-umount $(MP)/dev/pts
	-umount $(MP)/proc
	-umount $(MP)/sys
	-umount $(MP)/boot
	-umount $(MP)/drivers
	-umount $(MP)$(LFSSRC)
	-umount $(MP)$(SRC)
	-umount $(MP)$(WD)
	-umount $(MP)$(ROOT)
	-rmdir $(MP)$(SRC) $(MP)$(WD) $(MP)$(ROOT)
	-rmdir $(MP)/boot $(MP)$(LFSSRC) $(MP)/drivers
	-umount $(MP)

zeroes: $(MKTREE)
	-dd if=/dev/zero of=$(MP)/zeroes
	-rm $(MP)/zeroes
	-make unmount

.PHONY: mount unmount clean_sources scrub clean iso chroot-gvim update-caches \
	final-environment re-adjust-toolchain ch-% ch-glibc-32 lfs-adjust-toolchain \
	lfs-%-scpt lfs-%-scpt-32 lfs-%-pass1 lfs-%-pass2 \
	gvim %-only-ch lfs-%-only lfs-%-only-pass1 lfs-%-only-pass2 lfs-wget \
	lfs-rm-wget blfs post-bash pre-bash tools pre-which zeroes
