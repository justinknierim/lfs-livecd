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
all:
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

# Rules to clean your tree. 
# "clean" removes package directories and
# "scrub" also removes all sources and the uname modules - basically
# returning the tree to the condition it was when it was unpacked

clean:
	@-rm -rf $(WD)
	@-rm -rf $(MP)$(WD)
	@-userdel lfs
	@-rm -rf /home/lfs
	@-rmmod uname_i486
	@$(MAKE) -C $(PKG)/wget clean
	@$(MAKE) -C $(PKG)/binutils clean
	@$(MAKE) -C $(PKG)/gcc clean
	@$(MAKE) -C $(PKG)/linux-libc-headers clean
	@$(MAKE) -C $(PKG)/glibc clean
	@$(MAKE) -C $(PKG)/tcl clean
	@$(MAKE) -C $(PKG)/expect clean
	@$(MAKE) -C $(PKG)/dejagnu clean
	@$(MAKE) -C $(PKG)/gawk clean
	@$(MAKE) -C $(PKG)/coreutils clean
	@$(MAKE) -C $(PKG)/bzip2 clean
	@$(MAKE) -C $(PKG)/gzip clean
	@$(MAKE) -C $(PKG)/diffutils clean
	@$(MAKE) -C $(PKG)/findutils clean
	@$(MAKE) -C $(PKG)/make clean
	@$(MAKE) -C $(PKG)/grep clean
	@$(MAKE) -C $(PKG)/sed clean
	@$(MAKE) -C $(PKG)/gettext clean
	@$(MAKE) -C $(PKG)/ncurses clean
	@$(MAKE) -C $(PKG)/patch clean
	@$(MAKE) -C $(PKG)/tar clean
	@$(MAKE) -C $(PKG)/texinfo clean

scrub: clean
	@-rm -rf sources
	@-rm -rf uname/*.ko uname/*mod.c uname/*.o uname/.uname* uname/.tmp*
	@-var=`find packages -name ".pass2"` && for i in $$var ; do rm -rf $$i ; done
