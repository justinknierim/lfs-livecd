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
	@echo "====> Making Uname Module"
	@echo ""
	@make -C /usr/src/linux SUBDIRS=$(MKTREE)/uname modules
	@-insmod uname/uname_i486.ko

tools: lfs-binutils-pass1 lfs-gcc-pass1 lfs-linux-libc-headers lfs-glibc


# Rules which can be called by themselves, if necessary
binutils-pass1: lfsuser
	$(MAKE) -C $(PKG)/binutils pre1

gcc-pass1: lfsuser
	$(MAKE) -C $(PKG)/gcc pre1

linux-libc-headers: lfsuser 
	$(MAKE) -C $(PKG)/$@ pre1

glibc: lfsuser
	$(MAKE) -C $(PKG)/$@ pre1


# DO NOT CALL THESE RULES - FOR SCRIPTING ONLY
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

scrub: clean
	@-rm -rf sources
	@-rm -rf uname/*.ko uname/*mod.c uname/*.o uname/.uname* uname/.tmp*
