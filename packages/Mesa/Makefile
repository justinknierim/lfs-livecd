# Mesa Makefile

NM= Mesa
VRS= 6.5.2
DIR= $(NM)-$(VRS)

FILE= MesaLib-$(VRS).tar.bz2
URL-$(FILE)= http://heanet.dl.sourceforge.net/sourceforge/mesa3d/$(FILE)
SHA-$(FILE)= ba860bb6ee57c02202342dfd5927464a068ea18f

FILE1= MesaDemos-$(VRS).tar.bz2
URL-$(FILE1)= http://heanet.dl.sourceforge.net/sourceforge/mesa3d/$(FILE1)
SHA-$(FILE1)= beac8b2fa9c6e25efd44b911d2d7952b2f87534c

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	$(std_build)

compile-stage2:
	unpack ../$(FILE1) --strip-components=1
	make linux-dri-x86 OPT_FLAGS="$(CFLAGS)" MKDEP="gccmakedep" INSTALL_DIR=/usr DRI_DRIVER_INSTALL_DIR=/usr/lib/dri
	make INSTALL_DIR=/usr DRI_DRIVER_INSTALL_DIR=/usr/lib/dri install
	sed -i 's@-l$$(GLUT_LIB)@@g' configs/default
	cd progs/xdemos ; make PROGS='glxinfo glxgears'
	cd progs/xdemos ; install -v -m755 glxinfo glxgears /usr/bin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
