# Expect Makefile

NM= expect
VRS= 5.43.0
DIR= $(NM)-5.43

FILE= $(NM)-$(VRS).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 854440d937c1d05103bf2d02f911005b739fa1e9

PATCH1= $(NM)-$(VRS)-spawn-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= ba903a7d04b4faa13c8b9db75e1537f55f28e82b

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)

compile-stage1:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=$(WD) --with-tcl=$(WD)/lib \
	--with-tclinclude=$(WD)/include --with-x=no
	make $(PM)
	make SCRIPTS="" install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot
