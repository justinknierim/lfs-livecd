# Tcl Makefile

NM= tcl
VRS= 8.5.5
DIR= $(NM)$(VRS)

FILE= $(DIR)-src.tar.gz
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/tcl/$(FILE)
SHA-$(FILE)= af0433feaa7be1da945a1f414c4b10485ffbd386

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	cd unix ; ./configure --prefix=$(WD)
	cd unix ; make
	cd unix ; make install
	chmod -v u+w $(WD)/lib/libtcl8.5.so
	cd unix ; make install-private-headers
	ln -s tclsh8.5 $(WD)/bin/tclsh

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot
