# Mesa Makefile

NM= Mesa
VRS= 6.5.1
DIR= $(NM)-$(VRS)

FILE= MesaLib-$(VRS).tar.bz2
URL-$(FILE)= http://heanet.dl.sourceforge.net/sourceforge/mesa3d/$(FILE)
SHA-$(FILE)= cd3b314808534b0306c7f89e9a72c9c23dbff239

FILE1= MesaDemos-$(VRS).tar.bz2
URL-$(FILE1)= http://heanet.dl.sourceforge.net/sourceforge/mesa3d/$(FILE1)
SHA-$(FILE1)= 6576410f51ff2c2bf68cec1dcb188ea26307bf56

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	$(std_build)

compile-stage2:
	unpack ../$(FILE1) --strip-components=1
ifeq ($(LFS-ARCH),ppc)
	make linux-dri-ppc OPT_FLAGS="$(CFLAGS)" MKDEP="gccmakedep" INSTALL_DIR=/usr DRI_DRIVER_INSTALL_DIR=/usr/lib/dri
else
ifeq ($(LFS-ARCH),x86)
	make linux-dri-x86 OPT_FLAGS="$(CFLAGS)" MKDEP="gccmakedep" INSTALL_DIR=/usr DRI_DRIVER_INSTALL_DIR=/usr/lib/dri
else
	make linux-dri OPT_FLAGS="$(CFLAGS)" MKDEP="gccmakedep" INSTALL_DIR=/usr DRI_DRIVER_INSTALL_DIR=/usr/lib/dri
endif
endif
	make INSTALL_DIR=/usr DRI_DRIVER_INSTALL_DIR=/usr/lib/dri install
	sed -i 's@-l$$(GLUT_LIB)@@g' configs/default
	cd progs/xdemos ; make PROGS='glxinfo glxgears'
	cd progs/xdemos ; install -v -m755 glxinfo glxgears /usr/bin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
