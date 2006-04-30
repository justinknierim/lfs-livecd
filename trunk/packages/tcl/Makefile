# Tcl Makefile

NM= tcl
VRS= 8.4.12
DIR= $(NM)$(VRS)

FILE= $(DIR)-src.tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 8f9808da2df0aeb2319ab10a4fc49295789fc43d

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)/

compile-stage1:
	cd unix ; cp configure configure.orig ; sed "s/relid'/relid/" configure.orig >configure
ifndef CROSS
	cd unix ; ./configure --prefix=$(WD)
else
	cd unix ; sed -i 's@\$$(prefix)/lib@\$$(prefix)/lib64@g' Makefile.in
	cd unix ; CC="gcc $(64FLAGS)" ./configure --prefix=/tools --libdir=$(WD)/lib64
endif
	cd unix ; make $(PM)
	cd unix ; make install
	cd unix ; make install-private-headers
	ln -s tclsh8.4 $(WD)/bin/tclsh

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot
