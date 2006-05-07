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
	cd unix ; ./configure --prefix=$(WD)
	cd unix ; make $(PM)
	cd unix ; make install
	cd unix ; make install-private-headers
	ln -s tclsh8.4 $(WD)/bin/tclsh

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot
