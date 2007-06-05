# Tcl Makefile

NM= tcl
VRS= 8.4.15
DIR= $(NM)$(VRS)

FILE= $(DIR)-src.tar.gz
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/tcl/$(FILE)
SHA-$(FILE)= fbfae3ca68633a10b3fe870018588ade0944caed

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	cd unix ; ./configure --prefix=$(WD)
	cd unix ; make
	cd unix ; make install
	cd unix ; make install-private-headers
	ln -s tclsh8.4 $(WD)/bin/tclsh

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot
