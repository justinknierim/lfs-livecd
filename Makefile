# Makefile for automating the LFS LiveCD build
# Written by Jeremy Huntwork, 2004-1-09

# Edit this line to match the mount-point of the
# partition you'll be using to build the cd.
MP= /mnt/lfs

# Don't edit these!
WD= /tools
WHICH= $(WD)/bin/which
FTPGET= $(WD)/bin/ftpget
MKTREE= $(MP)/mklivecd
SRC= sources
PKG= packages
CFLAGS= -Os -s

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
	@su - lfs -c "exec env -i LFS=$(MP) LC_ALL=POSIX PATH=/tools/bin:/bin:/usr/bin \
	 /bin/bash -c 'set +h && umask 022 && cd $(MKTREE) && make which && make wget && make tools'"

lfsuser:
	@-groupadd lfs
	@-useradd -s /bin/bash -g lfs -m -k /dev/null lfs
	@chown -R lfs $(WD) $(MP)$(WD) $(WD)/bin $(SRC) $(PKG)

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

tools:

clean:
	@-rm -rf $(WD)
	@-rm -rf $(MP)$(WD)
	@-userdel lfs
	@-rm -rf /home/lfs
	@$(MAKE) -C $(PKG)/wget clean
