# [package-name] Makefile

# Package versions
NM= [package-name]
VRS= 1.2.3
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH1= $(DIR)-some_patch-1.patch
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH1)

# RULES

.PHONY: stage1 clean stage2 chroot

# Stage1 is for packages built to the /tools dir in the base LFS
stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi # This command, mv file to sources directory, is only for LFS Core packages and patches
	@if [ ! -f $(WD)/bin/ls ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=$(WD) && make -j3 && make install ; fi
	@make clean

# This target allows us to chroot if we haven't already
# Useful if the make has bombed and we want to build just
# this package for the chroot environment. In that case, we
# just call "make package-name" from the top directory, and
# this target is used to enter chroot and recall the ch-package-name
# target from the top Makefile.
chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

# This target is for building the package once we're already inside
# the chroot environment.
stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi # This command, mv file to sources directory, is only for LFS Core packages and patches
	@if [ ! -f $(SRC)/$(PATCH1) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH1) $(SRC) ; fi # This command, mv file to sources directory, is only for LFS Core packages and patches
	@if [ ! -f /bin/ls ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH1) && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install ; fi
	@make clean
	 
# Does what it says
clean:
	@-rm -rf $(DIR)
