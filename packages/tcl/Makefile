# Tcl Makefile

NM= tcl
VRS= 8.4.12
DIR= $(NM)$(VRS)

FILE= $(DIR)-src.tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= f906b8af7eebc9b8b55ff515666eff275e18756d

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build_noclean)
	cp $(SRC)/$(FILE) $(LFSSRC)/

compile-stage1:
	cd unix ; cp configure configure.orig ; sed "s/relid'/relid/" configure.orig >configure
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
