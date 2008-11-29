# Kbd Makefile

NM= kbd
VRS= 1.14.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 12d91613096d1a724fc780e2d7974a0a1b308dce

PATCH1= $(DIR)-backspace-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 66a421533f6c8e5c38db57c1e25f1842db7b82ae

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	sed -i -e '1i KEYCODES_PROGS = @KEYCODES_PROGS@' \
	 -e '1i RESIZECONS_PROGS = @RESIZECONS_PROGS@' src/Makefile.in
	var=OPTIONAL_PROGS
	sed -i "s/ifdef $$var/ifeq (\$$($$var),yes)/" man/Makefile.in
	unset var
	./configure --prefix=/usr --datadir=/lib/kbd
	make
	make install
	mv /usr/bin/{kbd_mode,loadkeys,openvt,setfont} /bin
	mkdir -v /usr/share/doc/$(DIR)
	cp -R -v doc/* /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
