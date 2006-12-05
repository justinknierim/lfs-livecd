# Tcl Makefile

NM= tcl
VRS= 8.4.14
DIR= $(NM)$(VRS)

FILE= $(DIR)-src.tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= d7af7e0c7ed563e2344dda04bbe49961589244dd

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)/

compile-stage1:
	cd unix ; ./configure --prefix=$(WD)
	cd unix ; make $(PM)
	cd unix ; make install
	cd unix ; make install-private-headers
	ln -s tclsh8.4 $(WD)/bin/tclsh

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot
