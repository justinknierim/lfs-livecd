# Makefile for automating the LFS LiveCD build
# Written by Jeremy Huntwork, 2004-1-09

# Edit this line to match the mount-point of the
# partition you'll be using to build the cd.
MP= /mnt/lfs

# Don't edit these!
WD= /tools
SRC= sources
PKG= packages
MKTREE= $(MP)/mklivecd
PWD= $(PKG)/wget
CFLAGS= -Os -s

# Package versions
VRS= 1.9.1
DIR= wget-$(VRS)
FILE= $(DIR).tar.gz

#RULES
prebuild:
	@if [ ! -f /tools/bin/wget ] ; then cd $(MKTREE)/$(SRC) && ftpget && cd $(MKTREE)/$(PWD) && \
	 tar xzf $(MKTREE)/$(SRC)/$(FILE) && cd $(DIR) && ./configure --prefix=$(WD) && make && make install ; fi
	@-rm -rf $(DIR)

clean:
	@-rm -rf $(DIR)
