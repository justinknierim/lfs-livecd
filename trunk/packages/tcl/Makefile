# Tcl Makefile

NM= tcl
VRS= 8.4.11
DIR= $(NM)$(VRS)

FILE= $(DIR)-src.tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 03b03db90de2815266948db4d0380e16ca07348c

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build_noclean)
	cp $(SRC)/$(FILE) $(LFSSRC)/

compile-stage1:
ifndef CROSS
	cd unix ; ./configure --prefix=$(WD)
else
	cd unix ; sed -i 's@\$(prefix)/lib@\$(prefix)/lib64@g' Makefile.in
	cd unix ; CC="gcc $(64FLAGS)" ./configure --prefix=/tools --libdir=/tools/lib64
endif
	cd unix ; make $(PM)
	cd unix ; make install
	ln -s tclsh8.4 $(WD)/bin/tclsh

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot
