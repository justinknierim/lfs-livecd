# Expect Makefile

NM= expect
VRS= 5.43.0
DIR= $(NM)-5.43

FILE= $(NM)-$(VRS).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= a73530772f9d735e98175c7807efa8e785c5fa60

PATCH1= $(NM)-$(VRS)-spawn-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= ba903a7d04b4faa13c8b9db75e1537f55f28e82b

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1)} $(LFSSRC)
	make -C ../tcl clean

compile-stage1:
	patch -Np1 -i ../$(PATCH1)
ifneq ($(LFS-ARCH),x86_64)
	./configure --prefix=$(WD) --with-tcl=$(WD)/lib \
	--with-tclinclude=$(ROOT)/$(PKG)/tcl/tcl8.4.11 --with-x=no
else
	CC="gcc $(64FLAGS)" ./configure --prefix=$(WD) --with-tcl=$(WD)/lib64 \
	--with-tclinclude=$(ROOT)/$(PKG)/tcl/tcl8.4.11 --libdir=$(WD)/lib64 \
	--with-x=no
endif
	make $(PM)
	make SCRIPTS="" install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot
